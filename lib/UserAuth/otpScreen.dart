import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isow/UserAuth/passresetScreen.dart';
import 'package:toast/toast.dart';
import '2_signinpage.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  final String email;

  OtpScreen({Key key, @required this.email}) : super(key: key);
  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = new TextEditingController();
  Future otpVerify(String email, String otp) async {
    var data = {
      'OTP': otp,
      'email': email,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/ResetPassword/CheckverificationCode',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("OTP Verified successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 2),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForgotPassScreen(
                        email: email,
                      ))));
    } else {
      Toast.show("Invalid OTP", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blueAccent,
      //   centerTitle: true,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      //   title: Text(
      //     'Forget password',
      //   ),
      // actions: [
      //   Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 16),
      //     child: Icon(Icons.more_vert),
      //   ),
      // ],
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //           colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
      // ),
      //   elevation: 0,
      // ),
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
                  "Enter your Five digit OTP",
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
                  controller: _otpController,
                  decoration: new InputDecoration(
                    // suffixIcon: Icon(
                    //   Icons.email_outlined,
                    //   color: Colors.white,
                    // ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'OTP',
                    filled: true,
                    // fillColor: Colors.white24,
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
                    if (_otpController.text.length != 5) {
                      Toast.show("Please enter 5 digit OTP", context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          textColor: Colors.red,
                          backgroundColor: Colors.white);
                    } else {
                      otpVerify(widget.email, _otpController.text);
                      _otpController.clear();
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
                        "Send reset link",
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
