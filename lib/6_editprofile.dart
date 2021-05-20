import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  Future<Note> note;
//  static var dname;

  @override
  void initState() {
    super.initState();
    note = fetchNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Edit Profile',
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
          future: fetchNote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var aname = snapshot.data.name;
              var auserId = snapshot.data.userId;
              var aemail = snapshot.data.email;
              var awork = snapshot.data.work;
              var amob_num = snapshot.data.mob_num;

              return Container(
                child: Column(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Card(
                        margin: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(220),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        color: Color(0xFF4fc4f2),
                        child: new Container(
                          height: 250.0,
                          child: new Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                    radius: 39.0,
                                    child: Icon(Icons.camera_alt,
                                        size: 30.0, color: Colors.white),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'name : $aname',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      'Newyork',
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
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      ListTile(
                        contentPadding:
                            EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
                        leading: MaterialButton(
                          onPressed: () {},
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
                          'name : $aname',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
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
                            Icons.person_pin_sharp,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                        title: Text(
                          'Employee ID\n$auserId',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
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
                            Icons.mail_outline,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                        title: Text(
                          'E-mail Address\n$aemail',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
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
                            Icons.work_outline_outlined,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                        title: Text(
                          'Work\n$awork',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
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
                            Icons.phone_android_outlined,
                            size: 25,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                        title: Text(
                          'Mobile Number\n$amob_num',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
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
                              constraints: BoxConstraints(
                                  maxWidth: 170.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Edit Profile",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Future<Note> fetchNote() async {
  try {
    // var id;
    Map<String, String> body = {
      'id': '13',
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
        userId: details['userId'] as String,
        email: details['email'] as String,
        work: details['work'] as String,
        mob_num: details['mob_num'] as String,
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

  Note({this.name, this.userId, this.email, this.work, this.mob_num});

  factory Note.fromJson(Map<String, String> json) {
    return Note(
      name: json['name'],
      userId: json['userid'],
      email: json['email'],
      work: json['work'],
      mob_num: json['mob_num'],
    );
  }
}
