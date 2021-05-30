import 'dart:async';

import 'package:flutter/material.dart';
import 'UserAuth/2_signinpage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '7_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String sid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;
      error = false;
    });
  }

  @override
  void initState() {
    // getValidation().whenComplete(() async {
    //   Timer(Duration(seconds: 2),
    //       () => sid == null ? SigninScreen() : HomeScreen());
    // });
    super.initState();
    getValidation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: error == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : sid == null
              ? SigninScreen()
              : HomeScreen(),
    );
  }
}
