import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import '21_jobdescriptionissuer.dart';
import 'package:isow/JobDescription/jobDescriptionList.dart';

class JobHandoverList extends StatefulWidget {
  // final String email;
  // Contact({Key key, @required this.email}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<JobHandoverList> {
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  int id = 0;
  Future fetchIssued() async {
    var data = {
      'toId': '5',
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobRequest/singleList',
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

  getColor(String str) {}

  @override
  void initState() {
    fetchIssued();

    super.initState();
  }

  Widget selectStatus(int idd) {
    return Container(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  Icons.close_rounded,
                  size: 30,
                  color: Colors.red[400],
                ),
                Text(
                  "Handover",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red[400],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green[400],
                ),
                Text(
                  "Accept",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[400],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Job Description",
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      //   actions: [
      //     Icon(
      //       Icons.headset_mic,
      //       color: Colors.white38,
      //     ),
      //     SizedBox(
      //       width: 5,
      //     ),
      //     Icon(
      //       Icons.logout,
      //       color: Colors.white38,
      //     ),
      //     SizedBox(
      //       width: 5,
      //     ),
      //     Icon(
      //       Icons.menu,
      //       color: Colors.white38,
      //     ),
      //   ],
      // ),
      body: jobError == true || mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration:
                  BoxDecoration(color: Color(0xFF4fc4f2).withOpacity(0.2)),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: listFacts.length == 0
                  ? Center(child: Text("No Hndoverd Jobs"))
                  : ListView.builder(
                      itemCount: listFacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final Message chat = chats[index];
                        return GestureDetector(
                          onTap: () {
                            showDialogFunc(
                              context,
                              listFacts[index]["assignedBy"],
                              listFacts[index]["assignedTo"],
                              listFacts[index]["sender"],
                              listFacts[index]["duration"],
                              listFacts[index]["job_description"],
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
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
                                            child: Text(
                                              listFacts[index]["sender"]
                                                  .substring(0, 1),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          title: Text(
                                            '${listFacts[index]["sender"][0].toUpperCase()}${listFacts[index]["sender"].substring(1)}',
                                            //  listFacts[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.5),
                                          ),
                                          subtitle: Text(
                                            listFacts[index]["duration"],
                                          ),
                                          trailing: selectStatus(1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}

showDialogFunc(context, by, to, byName, duration, description) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          type: MaterialType.card,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            height: 400,
            width: 350,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(3),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFF4fc4f2),
                                child: Text(
                                  byName.substring(0, 1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                '${byName[0].toUpperCase()}${byName.substring(1)}',
                                // title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 1.5),
                              ),
                              subtitle: Text(
                                duration,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    //  padding: EdgeInsets.all(8),
                    scrollDirection: Axis.vertical, //.horizontal
                    child: new Text(
                        '${description[0].toUpperCase()}${description.substring(1)}',
                        // requirment,
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      width: 10.0,
                      height: 10.0,
                    ),
                    new SizedBox(
                      width: 130.0,
                      height: 45.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 30,
                        child: Text(
                          ' OK ',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
