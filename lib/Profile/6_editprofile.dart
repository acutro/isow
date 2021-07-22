import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'editProfile.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;

  EditProfileScreen({Key key, @required this.userId}) : super(key: key);
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  Future<Note> note;
//  static var dname;

  @override
  void initState() {
    super.initState();
    getValidation();
  }

  String sid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;
      note = fetchNote(id);
      error = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Note>(
          future: fetchNote(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var aname = snapshot.data.name;
              var auserId = snapshot.data.userId;
              var aemail = snapshot.data.email;
              var awork = snapshot.data.work;
              var amob_num = snapshot.data.mob_num;
              var aroleid = snapshot.data.roleId;
              var propic = snapshot.data.propic;

              return Container(
                padding: EdgeInsets.all(15),
                alignment: AlignmentDirectional.centerEnd,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset("assets/images/logo.png",
                                  color: Colors.blue,
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.fill),
                            ),
                            Text(
                              'I Sow',
                              style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(getpath(propic),
                            height: 230, width: 190, fit: BoxFit.cover),
                      ),
                      Text(
                        aname,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 24,
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        awork,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ID# $auserId',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        amob_num,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        aemail,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      // Column(
                      //   children: <Widget>[
                      //     Card(
                      //       margin: const EdgeInsets.all(0.0),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(220),
                      //           topRight: Radius.circular(0),
                      //         ),
                      //       ),
                      //       color: Color(0xFF4fc4f2),
                      //       child: new Container(
                      //         height: 250.0,
                      //         child: new Container(
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //             children: <Widget>[
                      //               Center(
                      //                 child: ClipRRect(
                      //                   borderRadius: BorderRadius.circular(100000),
                      //                   child: CircleAvatar(
                      //                     radius: 45,
                      //                     child: Image.network(getpath(propic),
                      //                         height: 100,
                      //                         width: 100,
                      //                         fit: BoxFit.cover),
                      //                   ),
                      //                 ),
                      //               ),
                      //               Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: <Widget>[
                      //                   Text(
                      //                     'Name : $aname',
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         color: Colors.white,
                      //                         fontSize: 15.0),
                      //                   ),
                      //                   SizedBox(height: 5.0),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Column(
                      //   children: <Widget>[
                      //     SizedBox(height: 40),
                      //     ListTile(
                      //       contentPadding:
                      //           EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                      //       leading: MaterialButton(
                      //         onPressed: () {},
                      //         color: Colors.white,
                      //         textColor: Color(0xFF4fc4f2),
                      //         child: Icon(
                      //           Icons.perm_identity,
                      //           size: 25,
                      //         ),
                      //         padding: EdgeInsets.all(16),
                      //         shape: CircleBorder(),
                      //       ),
                      //       title: Text(
                      //         'Name : $aname',
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     ListTile(
                      //       contentPadding:
                      //           EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                      //       leading: MaterialButton(
                      //         onPressed: () {},
                      //         color: Colors.white,
                      //         textColor: Color(0xFF4fc4f2),
                      //         child: Icon(
                      //           Icons.person_pin_sharp,
                      //           size: 25,
                      //         ),
                      //         padding: EdgeInsets.all(16),
                      //         shape: CircleBorder(),
                      //       ),
                      //       title: Text(
                      //         'Employee ID\n$auserId',
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     ListTile(
                      //       contentPadding:
                      //           EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                      //       leading: MaterialButton(
                      //         onPressed: () {},
                      //         color: Colors.white,
                      //         textColor: Color(0xFF4fc4f2),
                      //         child: Icon(
                      //           Icons.mail_outline,
                      //           size: 25,
                      //         ),
                      //         padding: EdgeInsets.all(16),
                      //         shape: CircleBorder(),
                      //       ),
                      //       title: Text(
                      //         'E-mail Address\n$aemail',
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     ListTile(
                      //       contentPadding:
                      //           EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                      //       leading: MaterialButton(
                      //         onPressed: () {},
                      //         color: Colors.white,
                      //         textColor: Color(0xFF4fc4f2),
                      //         child: Icon(
                      //           Icons.work_outline_outlined,
                      //           size: 25,
                      //         ),
                      //         padding: EdgeInsets.all(16),
                      //         shape: CircleBorder(),
                      //       ),
                      //       title: Text(
                      //         'Work\n' +
                      //             '${awork[0].toUpperCase()}${awork.substring(1)}',
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     ListTile(
                      //       contentPadding:
                      //           EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                      //       leading: MaterialButton(
                      //         onPressed: () {},
                      //         color: Colors.white,
                      //         textColor: Color(0xFF4fc4f2),
                      //         child: Icon(
                      //           Icons.phone_android_outlined,
                      //           size: 25,
                      //         ),
                      //         padding: EdgeInsets.all(16),
                      //         shape: CircleBorder(),
                      //       ),
                      //       title: Text(
                      //         'Mobile Number\n$amob_num',
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Container(
                      //     height: 50.0,
                      //     child: RaisedButton(
                      //       onPressed: () {
                      //         Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => EditProfile(
                      //                     name: aname,
                      //                     empid: auserId,
                      //                     email: aemail,
                      //                     work: awork,
                      //                     mob: amob_num,
                      //                     roleid: aroleid,
                      //                     propic: propic,
                      //                   )),
                      //         );
                      //       },
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(80.0)),
                      //       padding: EdgeInsets.all(0.0),
                      //       child: Ink(
                      //         decoration: BoxDecoration(
                      //             gradient: LinearGradient(
                      //               colors: [Color(0xFF4fc4f2), Colors.blue],
                      //               begin: Alignment.centerLeft,
                      //               end: Alignment.centerRight,
                      //             ),
                      //             borderRadius: BorderRadius.circular(30.0)),
                      //         child: Container(
                      //           constraints: BoxConstraints(
                      //               maxWidth: 170.0, minHeight: 50.0),
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             "Edit Profile",
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //     SizedBox(
                      //       height: 30,
                      //     )
                      //   ],
                      // ),
                    ]),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              heightFactor: 5,
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<Note> fetchNote(String sidd) async {
  try {
    // var id;
    Map<String, String> body = {
      'id': sidd,
    };
    var response = await http.post(
        'http://isow.acutrotech.com/index.php/api/users/profile',
        body: body);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      var data = (json.decode(response.body));

      var detailsArray = data['data'];
      var details = detailsArray[0];
      print(details['name']);
      return Note(
        name: details['name'] as String,
        userId: details['empId'] as String,
        email: details['email'] as String,
        work: details['roleName'] as String,
        mob_num: details['mob_num'] as String,
        roleId: details['roleId'] as String,
        propic: details['profile_pic'] as String,
      );
    } else {
      throw Exception("Error");
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

class Note {
  final String name;
  final String userId;
  final String email;
  final String work;
  final String mob_num;
  final String roleId;
  final String propic;

  Note(
      {this.name,
      this.userId,
      this.email,
      this.work,
      this.mob_num,
      this.roleId,
      this.propic});

  factory Note.fromJson(Map<String, String> json) {
    return Note(
      name: json['name'],
      userId: json['empId'],
      email: json['email'],
      work: json['roleName'],
      mob_num: json['mob_num'],
      roleId: json['roleId'],
      propic: json['profile_pic'],
    );
  }
}
