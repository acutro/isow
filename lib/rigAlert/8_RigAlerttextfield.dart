import 'package:flutter/material.dart';

class RigAlertScreen extends StatefulWidget {
  @override
  RigAlertScreenState createState() => RigAlertScreenState();
}

class RigAlertScreenState extends State<RigAlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rig Alert',
          ),
        ),
        actions: [
          Icon(Icons.headset_mic),
          Icon(Icons.logout),
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
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 150.0, 0.0),
                    color: Color(0xFF4fc4f2),
                    child: new Container(
                      height: 100.0,
                      child: new Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/logorig.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
