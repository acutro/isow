import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '2_signinpage.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _useridController = new TextEditingController();
  TextEditingController _cpasswordController = new TextEditingController();

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.jpg"),
            fit: BoxFit.fitHeight,
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
                          border: Border.all(width: 1, color: Colors.white60)),
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
                          border: Border.all(width: 1, color: Colors.white60)),
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
                          border: Border.all(width: 1, color: Colors.white60)),
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
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                          border: Border.all(width: 1, color: Colors.white60)),
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
                          border: Border.all(width: 1, color: Colors.white60)),
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
                      RegistrationUser();
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
                      constraints:
                          BoxConstraints(maxWidth: 170.0, minHeight: 50.0),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninScreen()));

                  //signup screen
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future RegistrationUser() async {
    // url to registration php script
    var APIURL = "http://isow.acutrotech.com/index.php/api/users/register";
    //json maping user entered details
    Map mapeddate = {
      'name': _nameController.text,
      'email': _emailController.text,
      'userid': _useridController.text,
      'password': _passwordController.text,
      'confirmpassword': _cpasswordController.text,
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(APIURL, body: mapeddate);
    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    print("DATA: ${data}");
  }
}
