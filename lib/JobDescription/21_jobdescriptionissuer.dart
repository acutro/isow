import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '22_jobdescription.dart';
import 'JobDescriptionTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';

class Jobdescription extends StatefulWidget {
  final String userId;

  Jobdescription({Key key, @required this.userId}) : super(key: key);
  @override
  _JobdescriptionState createState() => _JobdescriptionState();
}

class _JobdescriptionState extends State<Jobdescription> {
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
      Toast.show("List is Empty", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future postJob(
    String id,
    String description,
    String duration,
  ) async {
    var data = {
      'assignedBy': widget.userId,
      'assignedTo': id,
      'job_description': description,
      'duration': duration
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobIssue/create',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Job added successfully", context,
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
        color: Color(0xff49A5FF),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: DropdownButton(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        iconEnabledColor: Colors.white,
        value: roleValue,
        dropdownColor: Color(0xff49A5FF),
        isExpanded: true,
        underline: Container(
          height: 0,
          color: roleError ? Colors.red : Colors.white,
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Position",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
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
                style: TextStyle(color: Colors.white, fontSize: 14),
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
        color: Color(0xff49A5FF),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: userResponse == null
          ? GestureDetector(
              onTap: () {
                Toast.show("Select Position", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    textColor: Colors.red,
                    backgroundColor: Colors.white);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  "Choose Position",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ))
          : DropdownButton(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              iconEnabledColor: Colors.white,
              value: userValue,
              dropdownColor: Color(0xff49A5FF),
              isExpanded: true,
              underline: Container(
                height: 0,
                color: userError ? Colors.red : Colors.white,
              ),
              hint: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Person",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
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
                      style: TextStyle(color: Colors.white, fontSize: 14),
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
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Issue a Job'),
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
                            decoration: BoxDecoration(
                              color: Color(0xff49A5FF),
                              borderRadius: BorderRadius.circular(50.0),
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
                            child: Icon(
                              Icons.contact_mail_outlined,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 360.0,
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            color: Color(0xff49A5FF),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
                                      height: 45.0,
                                      child: buildDropDownButton(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
                                      height: 45.0,
                                      child: personDropDownButton(),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 0.0),
                                  height: 45.0,
                                  child: TextField(
                                    controller: _descriptionController,
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      hintText: 'Job Description',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                height: 45.0,
                                child: TextField(
                                  controller: _durationController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Duration in Hour',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
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
                            } else if (_descriptionController.text == "" ||
                                _durationController.text == "") {
                              Toast.show(
                                  "Enter Description and Duration", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM,
                                  textColor: Color(0xff49A5FF),
                                  backgroundColor: Colors.white);
                            } else {
                              postJob(
                                userValue.toString(),
                                _descriptionController.text,
                                _durationController.text,
                              );

                              setState(() {
                                _descriptionController.text = "";
                                _durationController.text = "";
                              });
                              // Navigator.pop(context);

                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
