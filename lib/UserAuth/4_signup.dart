import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '2_signinpage.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  int roleValue;
  bool roleError = false;
  int rigValue;
  bool rigError = false;
  Map roleResponse;
  Map rigResponse;
  Map regResponse;
  List<dynamic> roleList;
  List<dynamic> rigList;
  Future fetchRig() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/orientation/rigList');
    if (response.statusCode == 200) {
      setState(() {
        rigResponse = jsonDecode(response.body);
        rigList = rigResponse['data'];
        print("{$rigList}");
      });
    }
  }

  Future fetchRole() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/userRoles/rolesList');
    if (response.statusCode == 200) {
      setState(() {
        roleResponse = jsonDecode(response.body);
        roleList = roleResponse['data'];
        print("{$roleList}");
      });
    }
  }

  Widget buildRigDownButton() {
    return DropdownButton(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      iconEnabledColor: Colors.white,
      value: rigValue,
      dropdownColor: Colors.blueAccent,
      isExpanded: true,
      underline: Container(
        height: 0,
        color: rigError ? Colors.red : Colors.white,
      ),
      hint: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Select Rig",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
      items: (rigList).map<DropdownMenuItem>((answer) {
        return DropdownMenuItem(
          value: int.parse(answer["id"]),
          child: Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              answer["rigName"],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: "WorkSansLight"),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          rigError = false;
          rigValue = value;

          print("$rigValue id of compny");
        });
        // print(companyValue.runtimeType);
      },
    );
  }

  Widget buildRoleDropDownButton() {
    return DropdownButton(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      iconEnabledColor: Colors.white,
      value: roleValue,
      style: TextStyle(color: Colors.white),
      dropdownColor: Colors.blueAccent,
      isExpanded: true,
      underline: Container(
        height: 0,
        color: roleError ? Colors.red : Colors.white,
      ),
      hint: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Select Role",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontFamily: "WorkSansLight"),
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
          roleError = false;
          roleValue = value;

          print("$roleValue id of compny");
        });
        // print(companyValue.runtimeType);
      },
    );
  }

  Future userReg(
    String name,
    String userIdd,
    String email,
    String pass,
    String mob,
    String rigId,
    String roleId,
  ) async {
    var data = {
      'name': name,
      'userId': userIdd,
      'email': email,
      'password': pass,
      'cpassword': pass,
      'roleId': roleId,
      'rigId': rigId,
      'work': 'Work',
      'mob_num': mob,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/users/register',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("User added successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
              ));
    } else {
      regResponse = jsonDecode(response.body);
      print(regResponse['message']);
      Toast.show(regResponse['message'], context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _useridController = new TextEditingController();
  TextEditingController _cpasswordController = new TextEditingController();
  TextEditingController _mobController = new TextEditingController();

  void _viewPass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _viewPass2() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  bool _obscureText = true;
  bool _obscureText1 = true;
  @override
  void initState() {
    super.initState();
    fetchRig();
    fetchRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   title: Text(
      //     'Sign up',
      //   ),
      // actions: [
      //   Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 16),
      //     child: Icon(Icons.more_vert),
      //   ),
      // ],
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(color: Colors.blueAccent
      // gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: <Color>[Color(0xFF4fc4f2), Colors.blue]),
      //         ),
      //   ),
      // ),
      body: roleResponse == null || rigResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              height: 110.0,
                              width: 110.0,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                            Text(
                              'Apps Signup',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: "WorkSansLight"),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.white60)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: _nameController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "enter the name";
                                }
                                return null;
                              },
                              onSaved: (String name) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.white60)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: _useridController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.perm_identity_sharp,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Employee Id",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter  Employee Id";
                                }
                                if (value.length <= 6) {
                                  return "Please enter valid Employee Id";
                                }
                                return null;
                              },
                              onSaved: (String userid) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.white60)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: _emailController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter  email";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                              onSaved: (String email) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.white60)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: _mobController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.mobile_friendly,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter Mobile Number";
                                }
                                if (value.length < 10) {
                                  return "Please enter valid Mobile Number";
                                }
                                return null;
                              },
                              onSaved: (String userid) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: Colors.white60)),
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              child: buildRoleDropDownButton()),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: Colors.white60)),
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              child: buildRigDownButton()),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.white60)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _viewPass();
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.lock_sharp
                                        : Icons.lock_open_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.white60)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: _cpasswordController,
                              obscureText: _obscureText1,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _viewPass2();
                                  },
                                  child: Icon(
                                    _obscureText1
                                        ? Icons.lock_sharp
                                        : Icons.lock_open_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter re-password";
                                }
                                if (_passwordController.text !=
                                    _cpasswordController.text) {
                                  return "Password Do not match";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            userReg(
                                _nameController.text,
                                _useridController.text,
                                _emailController.text,
                                _passwordController.text,
                                _mobController.text,
                                rigValue.toString(),
                                roleValue.toString());
                            AlertDialog(
                              title: Text("Successful"),
                            );
                            print("Successful");
                          } else {
                            AlertDialog(
                              title: Text("UnSuccessful"),
                            );
                            print("Unsuccessfull");
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Colors.blue[600],
                              // gradient: LinearGradient(
                              //   colors: [Color(0xFF4fc4f2), Colors.blue],
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              // ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 170.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        child: FlatButton(
                      textColor: Colors.white,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Back to ',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "WorkSansLight",
                              ),
                            ),
                            TextSpan(
                              text: 'sign in.',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "WorkSansLight",
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()));

                        //signup screen
                      },
                    )),
                  ],
                ),
              ),
            ),
    );
  }
}
