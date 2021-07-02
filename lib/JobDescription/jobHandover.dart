import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'JobDescriptionTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';

class JobHandover extends StatefulWidget {
  final String userId;
  final String jid;
  final String dec;
  final String dur;

  JobHandover({Key key, @required this.userId, this.jid, this.dec, this.dur})
      : super(key: key);
  @override
  _JobdescriptionState createState() => _JobdescriptionState();
}

class _JobdescriptionState extends State<JobHandover> {
  TextEditingController _descriptionController = new TextEditingController();

  TextEditingController _durationController = new TextEditingController();
  int roleValue;
  bool roleError = false;
  int userValue;
  bool userError = false;
  Map mapResponse;
  Map userResponse;
  List<dynamic> roleList;
  List<dynamic> userList;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/userRoles/rolesList');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        roleList = mapResponse['data'];
        print("{$roleList}");
      });
    }
  }

  Future fetchUsers(
    int id,
  ) async {
    var data = {
      'roleId': id.toString(),
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/UserRoles/usersList',
        body: (data));
    if (response.statusCode == 200) {
      setState(() {
        userResponse = jsonDecode(response.body);
        userList = userResponse['data'];
        print("{$userList}");
      });
    } else {
      setState(() {
        userList.clear();
      });
      Toast.show("List is Empty", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future handoverJob(
    String fromId,
    String toid,
    String jobid,
  ) async {
    var data = {'jobId': jobid, 'fromId': fromId, 'toId': toid};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobHandover/handovercreate',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Job Handoverd successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => JobDescriptionTab()),
              ));
    } else if (response.statusCode == 500) {
      Toast.show("This job is already assigned to this user", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    } else {
      Toast.show("Failed", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Widget buildDropDownButton() {
    return Container(
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: DropdownButton(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        iconEnabledColor: Colors.black87,
        value: roleValue,
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(
          height: 0,
          color: roleError ? Colors.red : Colors.white,
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "To Position",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        items: (roleList).map<DropdownMenuItem>((answer) {
          return DropdownMenuItem(
            value: int.parse(answer["id"]),
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                answer["userRoles"],
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            fetchUsers(value);
            roleError = false;
            roleValue = value;

            print("$roleValue id of compny");
          });
          // print(companyValue.runtimeType);
        },
      ),
    );
  }

  Widget personDropDownButton() {
    return Container(
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: userResponse == null
          ? GestureDetector(
              onTap: () {
                Toast.show("Select Person", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    textColor: Colors.red,
                    backgroundColor: Colors.white);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  "Choose Person",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ))
          : DropdownButton(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              iconEnabledColor: Colors.black87,
              value: userValue,
              dropdownColor: Colors.white,
              isExpanded: true,
              underline: Container(
                height: 0,
                color: userError ? Colors.red : Colors.white,
              ),
              hint: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "To Person",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              items: (userList).map<DropdownMenuItem>((answer) {
                return DropdownMenuItem(
                  value: int.parse(answer["id"]),
                  child: Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      answer["name"],
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  userError = false;
                  userValue = value;
                  print("$userValue id of compny");
                });
                // print(companyValue.runtimeType);
              },
            ),
    );
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(' Job Handover'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      body: mapResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Color(0xff49A5FF),
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 80.0,
                            width: 80.0,
                            child: InkWell(
                              child: Icon(
                                Icons.transfer_within_a_station,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // Navigator.push(
                                //   context,

                                //   MaterialPageRoute(
                                //       builder: (context) => Jobexecute()),
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 470,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                height: 45.0,
                                child: buildDropDownButton(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                height: 45.0,
                                child: personDropDownButton(),
                                //  TextField(
                                //   decoration: InputDecoration(
                                //     hintText: 'Name',
                                //     hintStyle: TextStyle(color: Colors.white),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(10.0)),
                                //       borderSide:
                                //           BorderSide(color: Colors.white),
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 150,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: Text(
                            widget.dec,
                            maxLines: 10,
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10)),
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                child: Text(
                                  widget.dur,
                                  maxLines: null,
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              height: 40.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),

                              //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (userValue == null) {
                              Toast.show("Select from Dropdown", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM,
                                  textColor: Color(0xff49A5FF),
                                  backgroundColor: Colors.white);
                            } else {
                              handoverJob(widget.userId, userValue.toString(),
                                  widget.jid);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
    );
  }
}
