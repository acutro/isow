import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import '21_jobdescriptionissuer.dart';
import 'package:isow/JobDescription/jobExecutedList.dart';
import 'jobHandover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobIssuedList extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<JobIssuedList> {
  String sid;
  String posid;
  bool error = true;
  _launchURL(String ur) async {
    String url = 'http://isow.acutrotech.com/assets/files/' + ur;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    String pos = sharedPreferences.getString('position');
    setState(() {
      posid = pos;
      sid = id;

      error = false;
      fetchIssued(id);
    });
  }

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    getValidation();
  }

  Future fetchIssued(String sessId) async {
    var data = {
      'assignedBy': sessId,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobIssue/singleList',
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
    super.initState();
    getValidation();
  }

  Widget _statusWidgect(String exe1, String hand2) {
    return Column(
      children: [
        Text(
          hand2 != '0' ? '' : 'Handovered',
          style: TextStyle(
              color: hand2 != '0' ? Colors.red : Colors.blue, fontSize: 12),
        ),
        SizedBox(
          height: 5,
        ),
        Text(exe1 == '0' ? 'Pending' : 'Executed',
            style: TextStyle(
                color: exe1 == '0' ? Colors.red : Colors.green, fontSize: 12)),
      ],
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: jobError == true || mapResponse == null
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
                    ? Center(child: Text("No Issued Jobs"))
                    : ListView.builder(
                        itemCount: listFacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              showDialogFunc(
                                context,
                                listFacts[index]["id"],
                                listFacts[index]["assignedBy"],
                                listFacts[index]["assignedTo"],
                                listFacts[index]["receiver"],
                                listFacts[index]["duration"],
                                listFacts[index]["job_description"],
                              );
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      // padding: EdgeInsets.all(2),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              child: Text(
                                                '${listFacts[index]["receiver"][0].toUpperCase()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            title: Text(
                                              listFacts[index][
                                                              "job_description"]
                                                          .length >
                                                      28
                                                  ? listFacts[index][
                                                              "job_description"]
                                                          .substring(0, 28) +
                                                      "..."
                                                  : listFacts[index]
                                                      ["job_description"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.1,
                                                  fontSize: 14),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Issued by :  " +
                                                      '${listFacts[index]["receiver"][0].toUpperCase()}${listFacts[index]["receiver"].substring(1)}' +
                                                      "\n" +
                                                      "Duration   :   " +
                                                      listFacts[index]
                                                          ["duration"] +
                                                      " hr" +
                                                      "\n" +
                                                      "Issued Date :   " +
                                                      listFacts[index]
                                                              ["issueDate"]
                                                          .substring(0, 10),
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                listFacts[index]["file_url"] !=
                                                        ""
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          _launchURL(
                                                              listFacts[index]
                                                                  ["file_url"]);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Attachement",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Icon(
                                                              Icons.attachment,
                                                              color:
                                                                  Colors.blue,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            trailing: Container(
                                                child: _statusWidgect(
                                                    listFacts[index]
                                                        ["executeStatus"],
                                                    listFacts[index]
                                                        ["handover_status"])),
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
      ),
      floatingActionButton: jobError == true || mapResponse == null
          ? Center()
          : posid == '4'
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Jobdescription(userId: sid)),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  label: Text("Issue"),
                )
              : null,
    );
  }
}

showDialogFunc(context, id, by, to, byName, duration, description) {
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
                                backgroundColor: Colors.blue,
                                child: Text(
                                  '${byName[0].toUpperCase()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                "By " +
                                    '${byName.toUpperCase()}${byName.substring(1)}',
                                // title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 1.5),
                              ),
                              subtitle: Text(
                                "Duration   :   " + duration + " hr",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                              // trailing: InkWell(
                              //     onTap: () {
                              //       Navigator.pop(context);
                              //     },
                              //     child: Icon(
                              //       Icons.delete,
                              //       color: Colors.red[400],
                              //     )),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 30,
                        child: Text(
                          ' OK ',
                          style: TextStyle(color: Colors.white),
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
