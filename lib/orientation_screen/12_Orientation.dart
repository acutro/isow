import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '13_OrientationRigs.dart';
import '14_orientaionmaterials.dart';
import 'package:readmore/readmore.dart';

class OrientationScreen extends StatefulWidget {
  @override
  OrientationScreenState createState() => OrientationScreenState();
}

class OrientationScreenState extends State<OrientationScreen> {
  String descText =
      "Description Line 1\nDescription Line 2\nDescription Line 3\nDescription Line 4\nDescription Line 5\nDescription Line 6\nDescription Line 7\nDescription Line 8";
  bool descTextShowFlag = false;
  Map mapResponse;
  String companyInfo;
  List<dynamic> roleList;
  Future fetchData() async {
    http.Response response;
    response =
        await http.get('http://isow.acutrotech.com/index.php/api/company/list');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);

        roleList = mapResponse['data'];

        print("{$roleList}");
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Orientation',
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      body: mapResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COMPANY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20.0),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ReadMoreText(
                            roleList[0]['description'].toString(),
                            trimLines: 8,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.0,
                                height: 1.5),
                            trimCollapsedText: '...Show more',
                            trimExpandedText: ' show less',
                          ),
                        ),
                        // child: Container(
                        //   child: Text(
                        //     roleList[0]['description'].toString(),

                        // ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: RaisedButton(
                        //     color: Colors.blue,
                        //     textColor: Colors.white,
                        //     child: Text('Read more..'),
                        //     onPressed: () => {},
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.only(
                        //         bottomRight: Radius.circular(20),
                        //         topRight: Radius.circular(20),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xFF4fc4f2),
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
                          // color: Color(0xFF4fc4f2),
                          child: new Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            child: Column(children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
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

                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
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
                                              color: Colors.blue,
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

                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
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
                                              color: Colors.blue,
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
