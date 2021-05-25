import 'package:flutter/material.dart';
import 'package:isow/7_home.dart';
import '3_forgotpswd.dart';
import '4_signup.dart';
import '../6_editprofile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SigninScreen extends StatefulWidget {
  @override
  SigninScreenState createState() => SigninScreenState();
}

class SigninScreenState extends State<SigninScreen> {
  bool visible = false;
  bool error = true;
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Future getLogin(String uname, String pass) async {
    var data = {'email': uname, 'password': pass};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/users/login',
        body: (data));
    if (response.statusCode == 200) {
      setState(() {
        //  mapResponse = jsonDecode(response.body);
        //   listFacts = mapResponse['data'];
        error = false;
        // print("{$listFacts}");
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        error = true;
      });
      Fluttertoast.showToast(
          msg: "Enter valid credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

//var finalname=EditProfileScreenState.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),

      appBar: AppBar(
        // leading: new IconButton(
        //   icon: new Icon(
        //     Icons.menu,
        //     color: Color(0xFF4fc4f2),
        //   ),
        //   onPressed: () {},
        // ),
        title: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //     child: Icon(Icons.more_vert),
        //   ),
        // ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                '\n'
                'Welcome\n',
                style: TextStyle(fontSize: 25, color: Color(0xFF4fc4f2)),
              ),
            ),
            Container(
              child: Text(
                'I.SOW\n',
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF4fc4f2),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                'Sign In\n',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 19.0),
              child: Text(
                'Please enter Email ID and Password',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                margin: new EdgeInsets.symmetric(horizontal: 20.0),

                /// padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 19.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF4fc4f2),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Email-ID',
                    filled: true,
                    fillColor: Colors.white24,
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "WorkSansLight"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black54,
                ),
                controller: _passwordController,
                obscureText: true,
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: Color(0xFF4fc4f2),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white24,
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: "WorkSansLight"),
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    'Remember me',
                    textAlign: TextAlign.left,
                  ),
                  FlatButton(
                    textColor: Color(0xFF4fc4f2),
                    child: Text(
                      'Forgot password?',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotpswdScreen()),
                      );

                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    'New one ?',
                    textAlign: TextAlign.left,
                  ),
                  FlatButton(
                    textColor: Color(0xFF4fc4f2),
                    child: Text(
                      'Signup',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      if (error == true) {
                        Fluttertoast.showToast(
                            msg: "This is Center Short Toast",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      }

                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  if (_emailController.text == "" ||
                      _passwordController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Please Enter Email and Password",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    getLogin(_emailController.text, _passwordController.text);
                  }

                  //signup screen
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4fc4f2), Colors.blue],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 170.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Future loginUser() async {
//     try {
//       setState(() {
//         visible = true;
//       });
//       // url to registration php script
//       //json maping user entered details

//       String email = _emailController.text;
//       String password = _passwordController.text;

//       var url = "http://isow.acutrotech.com/index.php/api/users/login";
//       var data = {'email': email, 'password': password};
//       var response = await http.post(url, body: (data));
//       var message = json.decode(response.body);
//       //Sign in once more
//       if (message["status"]) {
//         print("login Successful");
//         setState(() {
//           visible = false;
//         });
//       } else {
//         setState(() {
//           visible = false;
//         });
//       }
//     } catch (e) {
//       print(e);
//    }
  // }
}
