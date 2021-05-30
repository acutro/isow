import 'package:flutter/material.dart';
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

  Future handoverStatus(String status, String handStatus, String jobid) async {
    var data = {
      'jobId': jobid,
      'handoverStatus': status,
      'id': jobid,
      'handover_status': handStatus
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

  Widget selectStatus(String jobid) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              handoverStatus('2', '0', jobid);
              fetchIssued(sid);
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
              handoverStatus('1', '1', jobid);
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
                  ? Center(child: Text("No Handoverd Jobs"))
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
                                          trailing: listFacts[index]
                                                      ["handoverStatus"] ==
                                                  '0'
                                              ? selectStatus(
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
