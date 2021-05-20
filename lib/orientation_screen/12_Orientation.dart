import 'package:flutter/material.dart';
import '13_OrientationRigs.dart';
import '14_orientaionmaterials.dart';
import '../sizeadjust.dart';

class OrientationScreen extends StatefulWidget {
  @override
  OrientationScreenState createState() => OrientationScreenState();
}

class OrientationScreenState extends State<OrientationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Orientation',
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
                    margin: const EdgeInsets.all(0.0),
                    color: Colors.indigo,
                    child: new Container(
                      height: 400,
                      width: 1000,
                      child: new Container(
                        margin: const EdgeInsets.all(30.0),
                        child: Expanded(
                            child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Information About',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      'COMPANY',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 10.0),
                                    ),
                                  ]),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.all(0.0),
                    color: Color(0xFF4fc4f2),
                    child: new Container(
                      height: 500,
                      width: 1000,
                      child: new Container(
                        child: Column(children: <Widget>[
                          SizedBox(height: 70),
                          Wrap(
                            // alignment: WrapAlignment.end,
                            // direction: Axis.horizontal,
                            // spacing: 10.0,
                            // runSpacing: 20.0,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrientationRigScreen()),
                                  );
                                },
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/1.png'),
                                        radius: 39.0,
                                      ),
                                      margin: EdgeInsets.all(10),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Text(
                                        'Rigs',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 60),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrientationMaterialScreen()),
                                  );
                                },
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/2.png'),
                                        radius: 39.0,
                                      ),
                                      margin: EdgeInsets.all(10),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Text(
                                        'Materials',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
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
