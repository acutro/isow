import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '13_OrientationRigs.dart';
import '14_orientaionmaterials.dart';
import '../rigAlert/sizeadjust.dart';

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
          SizedBox(
            width: 10,
          ),
          Icon(Icons.logout),
          SizedBox(
            width: 10,
          )
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COMPANY',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Container(
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut.",
                        style: TextStyle(
                            color: Colors.white, fontSize: 12.0, height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),

              // child: Column(
              //   children: <Widget>[
              //     new Container(
              //       margin: const EdgeInsets.all(30.0),
              //       child: Expanded(
              //           child: Row(
              //         children: <Widget>[
              //           Flexible(
              //             child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Text(
              //                     'Information About',
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.white,
              //                         fontSize: 15.0),
              //                   ),
              //                   Text(
              //                     'COMPANY',
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.white,
              //                         fontSize: 20.0),
              //                   ),
              //                   SizedBox(height: 30),
              //                   Text(
              //                     "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut.",
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 12.0,
              //                         height: 1.5),
              //                   ),
              //                 ]),
              //           ),
              //         ],
              //       )),
              //     ),
              //   ],
              // ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.all(0.0),
                    color: Color(0xFF4fc4f2),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 500,
                      width: double.infinity,
                      child: Column(children: <Widget>[
                        SizedBox(height: 120),
                        Wrap(
                          alignment: WrapAlignment.end,
                          direction: Axis.horizontal,
                          spacing: 30.0,
                          runSpacing: 20.0,
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
                              child: Column(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 75,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(
                                            0.0,
                                            2.0,
                                          ),
                                        )
                                      ],

                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
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
                                    'Rigs',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrientationMaterialScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 75,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(
                                            0.0,
                                            2.0,
                                          ),
                                        )
                                      ],

                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
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
                                      FontAwesomeIcons.compass,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    margin: EdgeInsets.all(10),
                                  ),
                                  Text(
                                    "Materials",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14.0),
                                  )
                                ],
                              ),
                            ), // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               c),
                            //     );
                            //   },
                            //   child: Stack(
                            //     children: <Widget>[
                            //       Container(
                            //         child: CircleAvatar(
                            //           backgroundImage:
                            //               AssetImage('assets/1.png'),
                            //           radius: 39.0,
                            //         ),
                            //         margin: EdgeInsets.all(10),
                            //       ),
                            //       Positioned(
                            //         height: 10,
                            //         left: 40,
                            //         bottom: 0,
                            //         child: Text(
                            //           'Rigs',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.white,
                            //               fontSize: 10.0),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(width: 60),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               OrientationMaterialScreen()),
                            //     );
                            //   },
                            //   child: Stack(
                            //     children: <Widget>[
                            //       Container(
                            //         child: CircleAvatar(
                            //           backgroundImage:
                            //               AssetImage('assets/2.png'),
                            //           radius: 39.0,
                            //         ),
                            //         margin: EdgeInsets.all(10),
                            //       ),
                            //       Positioned(
                            //         left: 27,
                            //         bottom: 0,
                            //         child: Text(
                            //           'Materials',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.white,
                            //               fontSize: 10.0),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
