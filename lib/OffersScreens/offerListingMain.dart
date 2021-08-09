import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:isow/Widgects/alertBox.dart';
import 'package:toast/toast.dart';
import 'offerListing.dart';
import 'package:http/http.dart' as http;

class NewsListingMain extends StatefulWidget {
  final String path;
  final String title;
  final String catId;
  final String sid;
  NewsListingMain({Key key, this.path, this.title, this.catId, this.sid})
      : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<NewsListingMain> {
  List listResponse;
  bool jobError = false;
  Map mapResponse;
  List<dynamic> listFacts;
  Future fetchOffers(String siid) async {
    var data = {
      'category_id': siid,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Offers/singleList',
        body: (data));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        jobError = false;
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

  Timer _clockTimer;
  @override
  void initState() {
    fetchOffers(widget.catId);

    super.initState();
    _clockTimer = Timer.periodic(
        Duration(seconds: 4), (Timer t) => fetchOffers(widget.catId));
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
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
          GestureDetector(
            onTap: () {
              return showDialog(
                  context: context,
                  builder: (context) => BuildLogoutDialogclose(widget.sid));
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: listFacts == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: listFacts.length == 0
                    ? Center(child: Text("No Offers Available"))
                    : ListView.builder(
                        itemCount: listFacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OfferDetailScreen(
                                        title: widget.title,
                                        rigList: listFacts,
                                        id: index,
                                        sid: widget.sid)),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      int.parse(listFacts[index]["id"]) % 2 == 0
                                          ? Color(0xFF4fc4f2).withOpacity(0.2)
                                          : Colors.white),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    padding: EdgeInsets.all(3),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xFF4fc4f2),
                                            child: Image.asset(widget.path),
                                          ),
                                          title: Text(
                                            listFacts[index]["title"],
                                            // '${listFacts[index]["created_at"][0].toUpperCase()}${listFacts[index]["created_at"].substring(1)}',
                                            //  listFacts[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.5),
                                          ),
                                          subtitle: Text(
                                            listFacts[index]["description"]
                                                        .length >
                                                    120
                                                ? listFacts[index]
                                                        ["description"]
                                                    .substring(0, 120)
                                                : listFacts[index]
                                                    ["description"],
                                          ),
                                          // trailing: Text(
                                          //   listFacts[index]["description"]
                                          //       .substring(0, 10),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
