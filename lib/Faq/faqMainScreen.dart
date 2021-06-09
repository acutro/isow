import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';

class FaqScreen extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<FaqScreen> {
  List<bool> _isExpanded;
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future faqFetch() async {
    http.Response response;
    response = await http.get(
      'http://isow.acutrotech.com/index.php/api/FAQ/list',
    );
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        jobError = false;
        _isExpanded = List.generate(listFacts.length, (_) => false);
        print("{$listFacts}");
      });
    } else {
      jobError = true;

      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  @override
  void initState() {
    faqFetch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Faq",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Icon(
            Icons.headset_mic,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: jobError == true || mapResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: ExpansionPanelList(
                  expandedHeaderPadding:
                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  dividerColor: Color(0xFF4fc4f2).withOpacity(0.5),
                  animationDuration: Duration(seconds: 1),
                  expansionCallback: (index, isExpanded) => setState(() {
                    _isExpanded[index] = !isExpanded;
                  }),
                  children: [
                    for (int i = 0; i < listFacts.length; i++)
                      ExpansionPanel(
                        canTapOnHeader: true,
                        body: ListTile(subtitle: Text(listFacts[i]['answer'])),
                        headerBuilder: (_, isExpanded) {
                          return ListTile(
                              leading: Icon(
                                Icons.question_answer_rounded,
                                size: 35,
                                color: Color(0xFF4fc4f2),
                              ),
                              title: Text(listFacts[i]['question'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87)));
                        },
                        isExpanded: _isExpanded[i],
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
