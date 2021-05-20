import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sign up',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
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
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 01.0),
              child: Text(
                '\n'
                '\n'
                'Create New\n',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                'Employee Account\n',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 19.0),
              child: Text(
                'Please enter Employee Details and Password',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_pin_sharp,
                          color: Color(0xFF4fc4f2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular((90.0)),
                        )),
                        hintText: "Name",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "enter the name";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      controller: _useridController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_pin_sharp,
                          color: Color(0xFF4fc4f2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular((90.0)),
                        )),
                        hintText: "Employee Id",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
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
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF4fc4f2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular((90.0)),
                        )),
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
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
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: Color(0xFF4fc4f2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular((90.0)),
                        )),
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      controller: _cpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: Color(0xFF4fc4f2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular((90.0)),
                        )),
                        hintText: "Confirm Password",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
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
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
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
                      "Submit",
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
