import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Warningletter extends StatefulWidget {
  @override
  _WarningletterState createState() => _WarningletterState();
}

class _WarningletterState extends State<Warningletter> {
  TextEditingController _reasonController = new TextEditingController();

  TextEditingController issueController = new TextEditingController();

  String sid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;

      error = false;
    });
  }

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
      Toast.show(
        "No persons Found",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.red[400],
      );
    }
  }

  Future postWarning(
    String content,
    String toid,
    String userId,
    String issue,
  ) async {
    var data = {
      'content': content,
      'fromId': userId,
      'toId': toid,
      'issue': issue,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/WarningLetter/create',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Warning Letter sends successfull", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(Duration(seconds: 2), () => Navigator.pop(context));
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
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: DropdownButton(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        iconEnabledColor: Colors.black87,
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
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
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
              child: Text(
                "Choose Position",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ))
          : DropdownButton(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              iconEnabledColor: Colors.black87,
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
                    color: Colors.black54,
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
    getValidation();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Warning Letter'),
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
                    height: 10,
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(
                        Icons.list_alt_sharp,
                        size: 70.0,
                        color: Colors.blue,
                      ),
                      subtitle: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Issue  ',
                                style: TextStyle(fontSize: 26)),
                            TextSpan(text: 'Warning Letter'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 0.0),
                          //width: 200.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: buildDropDownButton(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 20.0, 15.0, 0.0),
                          //width: 200.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: personDropDownButton(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    //width: 200.0,
                    height: 45.0,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: 'Reason',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      autofocus: false,
                      maxLines: null,
                      controller: issueController,
                      keyboardType: TextInputType.text,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: 230.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Issue',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.blue)),
                            margin: EdgeInsets.all(10.0),
                            child: new TextField(
                              style: TextStyle(color: Colors.black87),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                              autofocus: false,
                              maxLines: 8,
                              controller: _reasonController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Container(
                  //         margin: EdgeInsets.all(20.0),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black26,
                  //               blurRadius: 6.0,
                  //               offset: Offset(0, 2),
                  //             ),
                  //           ],
                  //         ),
                  //         height: 230.0,
                  //         //width: 300.0,
                  //         //color: Colors.redAccent,
                  //         // child: Container(
                  //         child: Column(
                  //           children: <Widget>[
                  //             Container(
                  //               alignment: Alignment.topLeft,
                  //               margin:
                  //                   EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  //               child: Text(
                  //                 'Issue',
                  //                 style: TextStyle(
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //             ),
                  //             Expanded(
                  //               child: SingleChildScrollView(
                  //                 child: Container(
                  //                   margin: EdgeInsets.all(10.0),
                  //                   child: new TextField(
                  //                     decoration: new InputDecoration(
                  //                       border: InputBorder.none,
                  //                       focusedBorder: InputBorder.none,
                  //                       enabledBorder: InputBorder.none,
                  //                       errorBorder: InputBorder.none,
                  //                       disabledBorder: InputBorder.none,
                  //                     ),
                  //                     autofocus: false,
                  //                     maxLines: null,
                  //                     controller: _reasonController,
                  //                     keyboardType: TextInputType.text,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 200.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                                'Send',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(1.0)),
                              ),
                            ),
                            onTap: () {
                              if (userValue == null) {
                                Toast.show("Select from Dropdown", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    textColor: Color(0xff49A5FF),
                                    backgroundColor: Colors.white);
                              } else if (_reasonController.text == "") {
                                Toast.show("Enter Reason", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    textColor: Color(0xff49A5FF),
                                    backgroundColor: Colors.white);
                              } else {
                                postWarning(
                                    _reasonController.text,
                                    userValue.toString(),
                                    sid,
                                    issueController.text);

                                setState(() {
                                  _reasonController.text = "";
                                  issueController.text = "";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
    );
  }
}
