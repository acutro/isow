import 'package:flutter/material.dart';

class SafetyRule extends StatefulWidget {
  // final String email;
  // Contact({Key key, @required this.email}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<SafetyRule> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safety rules',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Safety rules",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            Icon(
              Icons.headset_mic,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.logout,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          color: Colors.yellow[800],
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "LIFE SAVING RULES",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 45,
              ),
              Text(
                "Work with a valid permit when required",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Obtain authorization before entering a confined space",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Verify isolation and zero energy before work begins ",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Obtain authorization before overriding or disabling safety controls",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Protect yourself against a fall when working at height",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Plan lifting operations and control the area ",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Follow the rules for working in toxic gas environments",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Follow the safe driving rules",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Keep yourself and others out of the line of fire ",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Divider(
                thickness: 2,
                color: Colors.black38,
                height: 30,
              ),
              Text(
                "Control flammables and ignition sources",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
