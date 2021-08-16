import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:toast/toast.dart';
import '2_signinpage.dart';

class ForgotPassScreen extends StatefulWidget {
  final String email;

  ForgotPassScreen({Key key, @required this.email}) : super(key: key);
  @override
  ForgotPassScreenState createState() => ForgotPassScreenState();
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController _cpasswordController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  Future passwordReset(String email, String pass) async {
    var data = {
      'email': email,
      'password': pass,
    };
    http.Response response;
    response = await http.post(UserAuthApi.resetPasswordApi, body: (data));
    if (response.statusCode == 200) {
      Toast.show("Password Reseted successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 2),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SigninScreen())));
    } else {
      Toast.show("Something went wrong try again", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                height: MediaQuery.of(context).size.height * 0.08,
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
                        'Forget Password?',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontFamily: "WorkSansLight"),
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 30.0),
                child: Text(
                  "Please enter new password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "WorkSansLight"),
                ),
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
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.016,
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
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    if (_passwordController.text == "" ||
                        _cpasswordController.text == "") {
                      Toast.show("Enter password and confirm password", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          textColor: Colors.red,
                          backgroundColor: Colors.white);
                    } else if (_passwordController.text.length < 6) {
                      Toast.show("Password must be 6 charecters", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          textColor: Colors.red,
                          backgroundColor: Colors.white);
                    } else if (_passwordController.text ==
                        _cpasswordController.text) {
                      passwordReset(widget.email, _passwordController.text);
                      _passwordController.clear();
                    } else {
                      Toast.show("Password not match", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          textColor: Colors.red,
                          backgroundColor: Colors.white);
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
                        "Reset Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
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
}
