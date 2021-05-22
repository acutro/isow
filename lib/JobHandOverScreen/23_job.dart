import 'package:flutter/material.dart';
import '24_jobhandovers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Jobhandovers extends StatefulWidget {
  @override
  _JobhandoversState createState() => _JobhandoversState();
}

class _JobhandoversState extends State<Jobhandovers> {
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

  Future fetchUsers() async {
    var data = {
      'roleId': roleValue.toString(),
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
      Fluttertoast.showToast(
          msg: "Enter valid credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future postWarning(
    String id,
    String description,
    String duration,
  ) async {
    var data = {
      'userId': id,
      'job_description': description,
      'duration': duration
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/JobDescription/create',
        body: (data));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Handover job successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
        items: roleList?.map<DropdownMenuItem>((answer) {
              return DropdownMenuItem(
                value: int.parse(answer["id"]),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    answer["userRoles"],
                    style: TextStyle(color: Colors.black38, fontSize: 14),
                  ),
                ),
              );
            })?.toList() ??
            [],
        onChanged: (value) {
          setState(() {
            roleError = false;
            roleValue = value;
            fetchUsers();
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
          ? Text("")
          : DropdownButton(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              iconEnabledColor: Colors.white,
              value: userValue,
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
              onChanged: (value) {
                setState(() {
                  userError = false;
                  userValue = value;

                  print("$userValue id of compny");
                });
                // print(companyValue.runtimeType);
              },
              items: userList?.map<DropdownMenuItem>((answer) {
                    return DropdownMenuItem(
                      value: int.parse(answer["id"]),
                      child: Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          answer["name"],
                          style: TextStyle(color: Colors.black38, fontSize: 14),
                        ),
                      ),
                    );
                  })?.toList() ??
                  [],
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
        title: Text(' Job Handovers'),
        centerTitle: true,
      ),
      body: mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
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
                            margin: EdgeInsets.only(right: 30.0),
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
                          Container(
                            margin: EdgeInsets.only(right: 30.0),
                            height: 100.0,
                            width: 90.0,
                            alignment: Alignment.bottomCenter,
                            child: Text('Handovers'),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30.0),
                            decoration: BoxDecoration(
                              color: Color(0xff49A5FF).withOpacity(0.8),
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
                                Icons.settings,
                                size: 40.0,
                                color: Colors.white60,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  // MaterialPageRoute(builder: (context) => Warningletter()),
                                  MaterialPageRoute(
                                      builder: (context) => Jobtransfer()),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30.0),
                            height: 100.0,
                            width: 90.0,
                            alignment: Alignment.bottomCenter,
                            child: Text('Transfer'),
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
                          height: 285.0,
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
                                      // TextField(
                                      //   decoration: InputDecoration(
                                      //     hintText: 'Position',
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
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
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
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
                                      height: 45.0,
                                      child: TextField(
                                        controller: _descriptionController,
                                        style: TextStyle(color: Colors.black38),
                                        decoration: InputDecoration(
                                          hintText: 'Job Description',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
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
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
                                      height: 45.0,
                                      child: TextField(
                                        controller: _durationController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Colors.black38),
                                        decoration: InputDecoration(
                                          hintText: 'Duration in Hour',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
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
                                ],
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
                                color: Color(0xff4fc4f2),
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
                              Fluttertoast.showToast(
                                  msg: "Select from Dropdown",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (_descriptionController.text == "" ||
                                _durationController.text == "") {
                              Fluttertoast.showToast(
                                  msg: "Enter Description and Duration",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              postWarning(
                                userValue.toString(),
                                _descriptionController.text,
                                _durationController.text,
                              );

                              setState(() {
                                _descriptionController.text = "";
                                _durationController.text = "";
                              });
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
