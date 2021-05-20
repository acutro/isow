import 'package:flutter/material.dart';
import '2_signinpage.dart';

class ForgotpswdScreen extends StatefulWidget {
  @override
  ForgotpswdScreenState createState() => ForgotpswdScreenState();
}

class ForgotpswdScreenState extends State<ForgotpswdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Forgot Password',
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
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: Text(
                '\n'
                '\n'
                '\n'
                '\n'
                '\n'
                '\n'
                'Forgot Password ?\n',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 19.0),
              child: Text(
                'Please enter Employee Email ID',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 19.0),
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color(0xFF4fc4f2),
                  ),
                  border: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide(color: Colors.white24)
                      //borderSide: const BorderSide(),
                      ),
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: "WorkSansLight"),
                  filled: true,
                  fillColor: Colors.white24,
                  hintText: 'E-mail ID',
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {},
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
                      "Send Reset Link",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    'Back to',
                    textAlign: TextAlign.left,
                  ),
                  FlatButton(
                    textColor: Color(0xFF4fc4f2),
                    child: Text(
                      'Sign In',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );

                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
