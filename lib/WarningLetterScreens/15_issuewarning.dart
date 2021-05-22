import 'package:flutter/material.dart';
import '16_RecievedWarningletter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Warningletter extends StatefulWidget {
  @override
  _WarningletterState createState() => _WarningletterState();
}

class _WarningletterState extends State<Warningletter> {
  TextEditingController _reasonController = new TextEditingController();

  TextEditingController issueController = new TextEditingController();
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
    String content,
    String issue,
    String toid,
  ) async {
    var data = {
      'content': content,
      'empId': '56574',
      'fromId': '2',
      'toId': toid,
      'issue': issue,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/WarningLetter/create',
        body: (data));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Warning Letter sends successfull",
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
        color: Colors.white,
        border: Border.all(color: Color(0xff4fc4f2), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: DropdownButton(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        iconEnabledColor: Colors.black54,
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
              color: Colors.black54,
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
                style: TextStyle(color: Colors.black54, fontSize: 14),
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
        border: Border.all(color: Color(0xff4fc4f2), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: userResponse == null
          ? Text("")
          : DropdownButton(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              iconEnabledColor: Colors.black54,
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
                      style: TextStyle(color: Colors.black54, fontSize: 14),
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
        backgroundColor: Color(0xff4fc4f2),
        title: Text('Warning Letter'),
        centerTitle: true,
      ),
      body: mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                        child: Icon(
                          Icons.list_alt_sharp,
                          size: 90.0,
                          color: Color(0xff4fc4f2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 40.0, 10.0, 0.0),
                          child: Center(
                            child: TextFormField(
                              cursorColor: Theme.of(context).cursorColor,
                              //initialValue: 'Opinion and Issue?',
                              maxLength: 20,
                              controller: issueController,
                              decoration: InputDecoration(
                                // icon: Icon(Icons.favorite),
                                labelText: 'Issue',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4fc4f2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff4fc4f2)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 20.0),
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
                          margin: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(20.0),
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
                          height: 230.0,
                          //width: 300.0,
                          //color: Colors.redAccent,
                          // child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                                child: Text(
                                  'Reason',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: new TextField(
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      autofocus: false,
                                      maxLines: null,
                                      controller: _reasonController,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 200.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xff4fc4f2),
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
                                Fluttertoast.showToast(
                                    msg: "Select from Dropdown",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (issueController.text == "" ||
                                  _reasonController.text == "") {
                                Fluttertoast.showToast(
                                    msg: "Enter Issue and Reason",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                postWarning(_reasonController.text,
                                    issueController.text, userValue.toString());

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
