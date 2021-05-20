import 'package:flutter/material.dart';

class ContactusChatboxScreen extends StatefulWidget {
  @override
  ContactusChatboxScreenState createState() => ContactusChatboxScreenState();
}

class ContactusChatboxScreenState extends State<ContactusChatboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Contact us Chat box',
          ),
        ),
        actions: [
          Icon(Icons.video_call),
          Icon(Icons.call),
          Icon(Icons.more_vert),
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
        child: Container(
          child: Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                          decoration: BoxDecoration(
                            color: Color(0xff49A5FF),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(15.0, 25.0, 20.0, 0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 40.0,
                                      margin: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 0.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10.0, 0.0, 50.0, 15.0),
                                          border: InputBorder.none,
                                          hintText: 'Type your message',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15.0,
                                      right: 0.1,
                                      child: Container(
                                        height: 30.0,
                                        //margin: EdgeInsets.fromLTRB(0.0, 10.0, 150.0, 0.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.send,
                                            color: Color(0xff49A5FF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30.0,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30.0,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.attach_file_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    margin: EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                      color: Color(0xff49A5FF),
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mic_none_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
