import 'dart:async';

import 'package:flutter/material.dart';
import 'UserAuth/2_signinpage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '7_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'id', 'test', 'test description',
    importance: Importance.high, playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBckgroundHndler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.messageId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBckgroundHndler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

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
