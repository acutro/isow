import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import '21_jobdescriptionissuer.dart';
import 'package:isow/JobDescription/jobDescriptionList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobHandoverList extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<JobHandoverList> {
  TextEditingController resonController = new TextEditingController();
  String sid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;
      fetchIssued(id);
      error = false;
    });
  }

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  int id = 0;
  Future fetchIssued(String sessid) async {
    var data = {
      'toId': sessid,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobHandover/userhandoveredList',
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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    getValidation();
  }

  Future handoverStatus(
      String jobid, String userid, String hstatus, String reson) async {
    var data = {
      'jobId': jobid,
      'userId': userid,
      'handoverStatus': hstatus,
      'reason': reson
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobHandover/handoverstatus',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Status changed Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
    } else {
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  @override
  void initState() {
    super.initState();
    getValidation();
  }

  Widget status(String id) {
    if (id == '1') {
      return Container(
        alignment: Alignment.center,
        width: 100,
        child: Text(
          "Accepted",
          style: TextStyle(color: Colors.green),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        width: 100,
        child: Text(
          "Rejected",
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }

  Widget selectStatus(String sid, String jobid) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 5.0,
                        type: MaterialType.card,
                        child: Container(
                          padding: EdgeInsets.all(25),
                          height: 280,
                          width: 320,
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  "Enter Reason",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.topLeft,

                                /// margin: EdgeInsets.all(20.0),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                height: 100.0,
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  maxLines: null,
                                  controller: resonController,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                  decoration: new InputDecoration(
                                    hintText: 'Reason',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  width: 120.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6.0,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    child: Center(
                                      child: Text(
                                        'Reject',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(1.0)),
                                      ),
                                    ),
                                    onTap: () {
                                      if (resonController.text == "") {
                                        Toast.show("Enter Reason", context,
                                            duration: Toast.LENGTH_SHORT,
                                            gravity: Toast.BOTTOM,
                                            textColor: Colors.blue[600],
                                            backgroundColor: Colors.white);
                                      } else {
                                        handoverStatus(jobid, sid, '2',
                                            resonController.text);
                                        fetchIssued(sid);
                                        Timer(
                                          Duration(seconds: 1),
                                          () => Navigator.pop(context),
                                        );
                                        fetchIssued(sid);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Column(
              children: [
                Icon(
                  Icons.cancel,
                  size: 30,
                  color: Colors.red[400],
                ),
                Text(
                  "Reject",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red[400],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              handoverStatus(jobid, sid, '1', "");
              fetchIssued(sid);
            },
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
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
                decoration:
                    BoxDecoration(color: Color(0xFF4fc4f2).withOpacity(0.2)),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: listFacts.length == 0
                    ? Center(child: Text("No Handoverd Jobs"))
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
                                              backgroundColor:
                                                  Color(0xFF4fc4f2),
                                              child: Text(
                                                listFacts[index]["id"],
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
                                                  height: 1.3,
                                                  fontSize: 14),
                                            ),
                                            subtitle: Text(
                                              "Handovered by :  " +
                                                  '${listFacts[index]["sender"][0].toUpperCase()}${listFacts[index]["sender"].substring(1)}' +
                                                  "\n" +
                                                  "Duration             :   " +
                                                  listFacts[index]["duration"] +
                                                  " hr" +
                                                  "\n" +
                                                  "Handover Date:   " +
                                                  listFacts[index]["issueDate"]
                                                      .substring(0, 10),
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            trailing: listFacts[index]
                                                        ["handoverStatus"] ==
                                                    '0'
                                                ? selectStatus(
                                                    sid,
                                                    listFacts[index]["jobId"],
                                                  )
                                                : status(listFacts[index]
                                                    ["handoverStatus"]),
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
                                backgroundColor: Color(0xFF4fc4f2),
                                child: Text(
                                  id,
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
