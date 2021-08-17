import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:isow/FireChatScreens/FirechatUsersList.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:isow/NewsScreens/26_news.dart';
import 'package:isow/main.dart';
import 'UserAuth/userReg.dart';
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
import 'package:http/http.dart' as http;
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
  TooltipBehavior _tooltipBehavior;
  Map graphResponse;
  List<ChartData> chartData = [];
  List<dynamic> graphList;
  Future fetchFlu() async {
    http.Response response;
    response = await http.get(OthersApi.oilFluctationApi);
    if (response.statusCode == 200) {
      setState(() {
        graphResponse = jsonDecode(response.body);
        graphList = graphResponse['data'];
        add(graphList);
        print("{$graphList}");
      });
    }
  }

  Map statusMap;

  List<dynamic> listFacts;
  Future fetchStatus(
    String id,
  ) async {
    var data = {
      'toId': id,
    };

    http.Response response;
    if (id != null) {
      response = await http.post(OthersApi.counterApi, body: (data));
      if (response.statusCode == 200) {
        setState(() {
          statusMap = jsonDecode(response.body);
          listFacts = statusMap['data'];
        });
        print(listFacts);
      }
    }
  }

  void add(List listd) {
    for (int i = 0; i < listd.length; i++) {
      chartData.add(ChartData(
          listd[i]['date'].substring(0, 5), double.parse(listd[i]['price'])));
    }
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    String pos = sharedPreferences.getString('position');
    setState(() {
      sid = id;

      posiid = pos;
      note = fetchNote(id);
      sid == '4'
          ? FirebaseMessaging.instance.subscribeToTopic("supervisor")
          : FirebaseMessaging.instance.subscribeToTopic("employee");
      FirebaseMessaging.instance.getToken().then((value) => upToken(id, value));
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
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        navigation(notification.title);
      }
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        navigation(message.notification.title);
      }
    });

    getValidation();
    fetchFlu();

    _tooltipBehavior = TooltipBehavior(
        enable: true,
        header: 'Price in AED',
        textStyle: TextStyle(color: Colors.white));
    _clockTimer =
        Timer.periodic(Duration(seconds: 8), (Timer t) => fetchStatus(sid));
  }

  Timer _clockTimer;
  void navigation(String title) {
    if (title == 'Job Issue' || title == 'Job Handover') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobDescriptionTab()),
      );
    } else if (title == 'Rig Alert') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecivedAlert()),
      );
    } else if (title == 'Warning Letter') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecivedWarning(
                  userid: sid,
                  posid: posiid,
                )),
      );
    } else if (title == 'Feedback') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedbackList()),
      );
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  Future upToken(
    String content,
    String token,
  ) async {
    var data = {
      'id': content,
      'token': token,
    };
    http.Response response;
    response = await http.post(FirebaseApi.fireTokenUpdateApi, body: (data));
    if (response.statusCode == 200) {
      print('Success');
    }
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
                      upToken(sid, "");
                      sid == '4'
                          ? FirebaseMessaging.instance
                              .unsubscribeFromTopic("supervisor")
                          : FirebaseMessaging.instance
                              .unsubscribeFromTopic("employee");
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SigninScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text("Yes")),
              ],
            ));
  }

  Future<bool> _onBackPressed() async {
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
      pathf = UserAuthApi.profileImageApi + 'default.png';

      return pathf;
    } else {
      pathf = UserAuthApi.profileImageApi + path;
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen(userId: sid)));
                            },
                            child: ListTile(
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
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: ListTile(
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
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FaqScreen()),
                              );
                            },
                            child: ListTile(
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
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SafetyRule()),
                              );
                            },
                            child: ListTile(
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
                          ),
                          SizedBox(height: 100),
                          GestureDetector(
                            onTap: _onLogout,
                            child: ListTile(
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
          body: graphResponse == null
              ? Center(
                  child: SpinKitChasingDots(
                    color: Colors.blue,
                    size: 120,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 35.0,
                        runSpacing: 25.0,
                        children: [
                          Stack(
                            children: [
                              statusMap == null || sid == '4'
                                  ? SizedBox()
                                  : Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Center(
                                        child: new Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          decoration: new BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 16,
                                            minHeight: 16,
                                          ),
                                          child: Text(
                                            listFacts[0]['rigalert'].toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
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

                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF4fc4f2),
                                            Colors.blue
                                          ],
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
                            ],
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
                          Stack(
                            children: [
                              statusMap == null || sid == '4'
                                  ? SizedBox()
                                  : Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Center(
                                        child: new Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          decoration: new BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 16,
                                            minHeight: 16,
                                          ),
                                          child: Text(
                                            listFacts[0]['warningletter']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                          colors: [
                                            Color(0xFF4fc4f2),
                                            Colors.blue
                                          ],
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
                            ],
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
                                MaterialPageRoute(
                                    builder: (context) => Emergency()),
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
                                MaterialPageRoute(
                                    builder: (context) => Services(sid: sid)),
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
                                  "Work Management",
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
                                    builder: (context) =>
                                        OfferMainScreen(sid: sid)),
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
                                MaterialPageRoute(
                                    builder: (context) => News(
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
                                    builder: (context) =>
                                        WeatherreportScreen()),
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
                                    builder: (context) => FireChatListScreen()),
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
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Text(
                              "Oil Fluctuation Graph",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                ),
                                child: SfCartesianChart(
                                  // legend: Legend(isVisible: true),
                                  tooltipBehavior: _tooltipBehavior,
                                  primaryXAxis: CategoryAxis(),
                                  series: <CartesianSeries>[
                                    AreaSeries<ChartData, String>(
                                      color: Colors.white.withOpacity(0.5),
                                      dataSource: chartData,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      // Map the data label text for each point from the data source
                                      dataLabelMapper: (ChartData data, _) =>
                                          data.y.toString(),
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ),

                                      enableTooltip: true,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                    ]),
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: posiid == '4'
              ? Container(
                  height: 40,
                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  width: MediaQuery.of(context).size.width,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegScreen()),
                      );
                    },
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

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
