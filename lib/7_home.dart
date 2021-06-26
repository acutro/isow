import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isow/NewsScreens/26_news.dart';
import 'package:isow/main.dart';
import 'ChatScreens/chatListScreen.dart';
import 'whetherScreens/27_weatherreport.dart';
import 'orientation_screen/12_Orientation.dart';
import 'WarningLetterScreens/16_RecievedWarningletter.dart';
import 'Emergency/18_emergency.dart';
import 'UserAuth/2_signinpage.dart';
import 'notepadScreen/notepadListScreen.dart';
import 'ServicesScreen/19_services.dart';
import 'OffersScreens/25_offers.dart';
import 'Profile/6_editprofile.dart';
import 'contacts/contact.dart';
import 'SafteyRules/safteyRules.dart';
import 'JobDescription/JobDescriptionTab.dart';
import 'FeedbackScreen/feedbackList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'rigAlert/alertList.dart';
import 'Faq/faqMainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String sid;
  String posiid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    String pos = sharedPreferences.getString('position');
    setState(() {
      sid = id;
      posiid = pos;
      note = fetchNote(id);
      error = false;
    });
  }

  @override
  Future<Note> note;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_laucher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatListScreen()),
        );
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return AlertDialog(
        //         title: Text(notification.title),
        //         content: SingleChildScrollView(
        //           child: Column(
        //             children: [Text(notification.body)],
        //           ),
        //         ),
        //       );
        //     });
      }
    });
    getValidation();
  }

  Future<bool> _onLogout() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SigninScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text("Yes")),
              ],
            ));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Are you sure you want to exit from i.SOW ?",
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No")),
                FlatButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("Yes")),
              ],
            ));
  }

  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = 'https://picsum.photos/250?image=9';

      return pathf;
    } else {
      pathf = 'http://isow.acutrotech.com/assets/profilepic/' + path;
      return pathf;
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          drawer: FutureBuilder<Note>(
              future: note,
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var item = snapshot.data.name;
                  var propic = snapshot.data.propic;
                  return Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF4fc4f2),
                    ),
                    child: Drawer(
                      elevation: 10.0,
                      child: ListView(
                        children: <Widget>[
                          DrawerHeader(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [Colors.blue, Color(0xFF4fc4f2)])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100000),
                                    child: CircleAvatar(
                                      radius: 35,
                                      child: Image.network(getpath(propic),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '$item',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(height: 5.0),
                                    // Text(
                                    //   'New york',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white,
                                    //       fontSize: 14.0),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 25.0),
                          ListTile(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            leading: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen(userId: sid)),
                                );

//signup screen
                              },
                              color: Colors.white,
                              textColor: Color(0xFF4fc4f2),
                              child: Icon(
                                Icons.perm_identity,
                                size: 25,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            leading: MaterialButton(
                              onPressed: () {},
                              color: Colors.white,
                              textColor: Color(0xFF4fc4f2),
                              child: Icon(
                                Icons.settings,
                                size: 25,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            leading: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FaqScreen()),
                                );
                              },
                              color: Colors.white,
                              textColor: Color(0xFF4fc4f2),
                              child: Icon(
                                Icons.question_answer,
                                size: 25,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            title: Text(
                              'Faq',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            leading: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SafetyRule()),
                                );
                              },
                              color: Colors.white,
                              textColor: Color(0xFF4fc4f2),
                              child: FaIcon(
                                FontAwesomeIcons.fire,
                                size: 25,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            title: Text(
                              'Safety Rules',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 100),
                          ListTile(
                            contentPadding:
                                EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                            leading: MaterialButton(
                              onPressed: _onLogout,
                              color: Colors.white,
                              textColor: Color(0xFF4fc4f2),
                              child: Icon(
                                Icons.logout,
                                size: 25,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Drawer(
                    child: Container(
                      color: Colors.white,
                    ),
                  );
                }
              }),
          appBar: AppBar(
            title: Center(
              child: Text('Home'),
            ),
            actions: [
              Icon(Icons.headset_mic),
              SizedBox(
                width: 20,
              ),
              GestureDetector(onTap: _onLogout, child: Icon(Icons.logout)),
              SizedBox(
                width: 20,
              ),
              // Icon(Icons.more_vert),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                SizedBox(height: 30),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 30.0,
                  runSpacing: 35.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecivedAlert()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],

                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.broadcastTower,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Rig Alert",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrientationScreen()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.compass,
                              size: 35,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Orientation",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Contact(
                                    sid: sid,
                                  )),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.users,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Contacts",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackList()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.comments,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Feed Back",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecivedWarning(
                                userid: sid,
                                posid: posiid,
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.envelopeOpenText,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Warning Letter",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotepadList()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.clipboardList,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Notepad",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Emergency()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.ambulance,
                              size: 35,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Emergency",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Services()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.personBooth,
                              size: 35,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Services",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobDescriptionTab()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.copy,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Job Description",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfferMainScreen()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.tags,
                              size: 35,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Offers",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => News()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.fileAlt,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "News",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherreportScreen()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.sun,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Weather",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatListScreen()),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.facebookMessenger,
                              size: 40,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                          Text(
                            "Chat",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),

                    // GestureDetector(
                    //   onTap: () {
                    //     flutterLocalNotificationsPlugin.show(
                    //         0,
                    //         'test',
                    //         'android notification',
                    //         NotificationDetails(
                    //             android: AndroidNotificationDetails(channel.id,
                    //                 channel.name, channel.description,
                    //                 importance: Importance.high,
                    //                 color: Colors.blue,
                    //                 playSound: true,
                    //                 icon: '@mipmap/ic_launcher')));
                    //   },
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         height: 65,
                    //         width: 65,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20)),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black54,
                    //               blurRadius: 3.0,
                    //               spreadRadius: 1.0,
                    //               offset: Offset(
                    //                 0.0,
                    //                 2.0,
                    //               ),
                    //             )
                    //           ],
                    //           gradient: LinearGradient(
                    //             colors: [Color(0xFF4fc4f2), Colors.blue],
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //           ),
                    //         ),
                    //         child: FaIcon(
                    //           FontAwesomeIcons.sun,
                    //           size: 40,
                    //           color: Colors.white,
                    //         ),
                    //         margin: EdgeInsets.all(10),
                    //       ),
                    //       Text(
                    //         "Nitification",
                    //         style: TextStyle(fontSize: 12),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),

                // Column(
                //   children: <Widget>[
                //     Card(
                //       margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                //       child: Container(
                //         height: 150.0,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //             bottomRight: Radius.circular(15),
                //             bottomLeft: Radius.circular(15),
                //             topLeft: Radius.circular(15),
                //             topRight: Radius.circular(15),
                //           ),
                //           gradient: LinearGradient(
                //               colors: [Color(0xFF4fc4f2), Colors.blue]),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 4),

                // Column(
                //   children: <Widget>[
                //     posiid == '4'
                //         ? GestureDetector(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => SignupScreen()),
                //               );
                //             },
                //             child: Card(
                //               margin: const EdgeInsets.all(0.0),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.only(
                //                   bottomRight: Radius.circular(0),
                //                   bottomLeft: Radius.circular(0),
                //                   topRight: Radius.circular(200),
                //                   topLeft: Radius.circular(200),
                //                 ),
                //               ),
                //               color: Color(0xFF4fc4f2),
                //               child: new Container(
                //                 height: 40.0,
                //                 child: new Container(
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceEvenly,
                //                     children: <Widget>[
                //                       Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.center,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: <Widget>[
                //                           Text(
                //                             'Create New Employee Account',
                //                             style: TextStyle(
                //                                 // fontWeight: FontWeight.bold,
                //                                 color: Colors.white,
                //                                 fontSize: 12.0),
                //                           ),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           )
                //         : SizedBox(
                //             height: 1,
                //           ),
                //  ],
                //  ),
              ]),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: posiid == '4'
              ? Container(
                  height: 40,
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(200),
                        topLeft: Radius.circular(200),
                      ),
                    ),
                    onPressed: () {},
                    label: Text(
                      'Create New Employee Account',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 12.0),
                    ),
                  ),
                )
              : null),
    );
  }
}
