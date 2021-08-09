import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:isow/UserAuth/2_signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BuildLogoutDialogclose extends StatelessWidget {
  final String sid;
  // final Function onTap;

  BuildLogoutDialogclose(
    this.sid,
  );

  Future upToken(
    String content,
    String token,
  ) async {
    var data = {
      'id': content,
      'token': token,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Token/update',
        body: (data));
    if (response.statusCode == 200) {
      print('Success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Do you want to logout ?",
        style: TextStyle(fontSize: 14),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("No")),
        FlatButton(
            onPressed: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('userId');
              upToken(sid, "");
              sid == '4'
                  ? FirebaseMessaging.instance
                      .unsubscribeFromTopic("supervisor")
                  : FirebaseMessaging.instance.unsubscribeFromTopic("employee");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Yes")),
      ],
    );
  }
}



  // Future<bool> _onLogout() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             );
  // }