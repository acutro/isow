import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text('News'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 100.0,
                  margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Icon(
                    Icons.new_releases_sharp,
                    size: 90.0,
                    color: Color(0xff49A5FF),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Color(0xff49A5FF),
                          height: 1.0,
                        ),
                        height: 55.0,
                        //color: Color(0xff49A5FF),
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                      ),
                      Container(
                          alignment: Alignment.bottomLeft,
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Company',
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.black54),
                                ),
                              ),
                              SizedBox(
                                width: 3.0,
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'News',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black54),
                                ),
                              )
                            ],
                          )),

                      // Container(
                      //   color: Colors.blueGrey,
                      // )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        width: MediaQuery.of(context).size.width / 3.3,
                        color: Color(0xff49A5FF),
                        child: Center(
                            child: Text(
                          'Today News',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        height: 80.0,
                        color: Color(0xff0E4D92),
                        child: Center(
                            child: Text('News',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        width: MediaQuery.of(context).size.width / 3.3,
                        color: Color(0xff49A5FF),
                        child: Center(
                            child: Text(
                          'Today News',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        height: 80.0,
                        color: Color(0xff0E4D92),
                        child: Center(
                            child: Text('News',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        width: MediaQuery.of(context).size.width / 3.3,
                        color: Color(0xff49A5FF),
                        child: Center(
                            child: Text(
                          'Today News',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        height: 80.0,
                        color: Color(0xff0E4D92),
                        child: Center(
                            child: Text('News',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Icon(
                    Icons.lock_clock,
                    size: 90.0,
                    color: Color(0xff49A5FF),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Color(0xff49A5FF),
                          height: 1.0,
                        ),
                        height: 55.0,
                        //color: Color(0xff49A5FF),
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 50.0,
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: Text(
                          'Activities',
                          style:
                              TextStyle(fontSize: 25.0, color: Colors.black54),
                        ),
                      ),

                      // Container(
                      //   color: Colors.blueGrey,
                      // )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 100.0,
                            child: Text(
                              'Team Building',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 80.0,
                            child:
                                Image.asset('assets/images/teambuilding.jpg'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 100.0,
                            child: Text(
                              'Sports',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 80.0,
                            child: Image.asset('assets/images/sports.jpg'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 100.0,
                            child: Text(
                              'Tour',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 80.0,
                            child: Image.asset('assets/images/tourr.jpg'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
