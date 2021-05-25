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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Center(
          child: Text(
            'Forgot Password',
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
                'Please enter your E-mail ID',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
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
                decoration: new InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Color(0xFF4fc4f2),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
            SizedBox(
              height: 20,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
