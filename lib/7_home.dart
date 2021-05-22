import 'package:flutter/material.dart';
import 'package:isow/26_news.dart';
import '27_weatherreport.dart';
import 'orientation_screen/12_Orientation.dart';
import 'FeedbackScreen/14_feedback.dart';
import 'WarningLetterScreens/16_RecievedWarningletter.dart';
import '18_emergency.dart';
import '4_signup.dart';
import 'page8rigalert.dart';
import 'notepadScreen/notepadListScreen.dart';
import '19_services.dart';
import '21_jobdescriptionissuer.dart';
import '25_offers.dart';
import 'JobHandOverScreen/23_job.dart';
import 'package:http/http.dart';
import '6_editprofile.dart';
import 'contacts/contact.dart';
import '2_signinpage.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Future<Note> note;
  @override
  void initState() {
    super.initState();
    note = fetchNote();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FutureBuilder<Note>(
          future: note,
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var item = snapshot.data.name;
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
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                radius: 35.0,
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
                                Text(
                                  'New york',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14.0),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0),

//Here you place your menu items
//                       ListTile(
//                         contentPadding:
//                             EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
//                         leading: MaterialButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => HomeScreen(),
//                               ),
//                             );
//                           },
//                           color: Colors.white,
//                           textColor: Color(0xFF4fc4f2),
//                           child: Icon(
//                             Icons.home_outlined,
//                             size: 25,
//                           ),
//                           padding: EdgeInsets.all(16),
//                           shape: CircleBorder(),
//                         ),
//                         title: Text(
//                           'Home',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                        leading: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()),
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
                      SizedBox(height: 100),

                      Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'LOGOUT',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SigninScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                ),
                              ],
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
            width: 5,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Icon(Icons.logout)),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.more_vert),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200),
                        bottomLeft: Radius.circular(200),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    color: Color(0xFF4fc4f2),
                    child: new Container(
                      height: 40.0,
                      child: new Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Create New Employee Account',
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.0),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Wrap(
                alignment: WrapAlignment.center,
                spacing: 30.0,
                runSpacing: 8.0,
                // alignment: WrapAlignment.end,
                // direction: Axis.horizontal,
                // spacing: 10.0,
                // runSpacing: 20.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RigAlert2()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/1.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Container(
                          //margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          height: 100.0,
                          width: 80.0,
                          alignment: Alignment.bottomCenter,
                          child: Text('Rig Alert'),
                        ),
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
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/2.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Container(
                          //margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          height: 100.0,
                          width: 80.0,
                          alignment: Alignment.bottomCenter,
                          child: Text('Orientation'),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   child: Text(
                        //     'Orientation',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.black,
                        //         fontSize: 10.0),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Contact()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/3.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Contacts',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedbackCounter()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/4.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Feed Back',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecivedWarning()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/5.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Warning Letter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotepadList()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/6.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Notepad',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
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
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/9.png'),
                            radius: 39.0,
                          ),
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Emergency',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
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
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/8.png'),
                            radius: 39.0,
                          ),
                          //onTap: () {},
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Services',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Jobdescription()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/7.png'),
                            radius: 39.0,
                          ),
                          //onTap: () {},
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Job Description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Jobhandovers()),
                      );
                    },
                    child: Stack(children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/10.png'),
                          radius: 39.0,
                        ),
                        //onTap: () {},
                        margin: EdgeInsets.all(10),
                      ),
                      SizedBox(height: 10),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Job Hand Overs',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 10.0),
                        ),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => offers()),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/11.png'),
                            radius: 39.0,
                          ),
                          //onTap: () {},
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Offers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
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
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/12.png'),
                            radius: 39.0,
                          ),
                          //onTap: () {},
                          margin: EdgeInsets.all(10),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'News',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
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
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/13.png'),
                            radius: 39.0,
                          ),
                          //onTap: () {},
                          margin: EdgeInsets.fromLTRB(75.0, 0.0, 0.0, 0.0),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Weather Report',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ]),
            Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                  child: Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                          colors: [Color(0xFF4fc4f2), Colors.blue]),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
