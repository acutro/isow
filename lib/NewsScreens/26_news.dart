import 'package:flutter/material.dart';
import 'newsListing.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
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
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  // final Message chat = chats[index];
                  return GestureDetector(
                    child: Row(
                      children: [
                        Card(
                          elevation: 5,
                          shadowColor: Color(0xff0E4D92),
                          color: Color(0xff0E4D92),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: MediaQuery.of(context).size.width / 2,
                                color: Color(0xff49A5FF),
                                child: Center(
                                    child: Text(
                                  'Today News',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height:
                                    MediaQuery.of(context).size.height / 5.3,
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
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: RaisedButton(
                color: Color(0xFF4fc4f2),
                textColor: Colors.white,
                child: Text('More News..'),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsListing()),
                  ),
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
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
                            child: Image.asset('assets/images/team.png'),
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
                            child: Image.asset('assets/images/sports.png'),
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
                            child: Image.asset('assets/images/tour.png'),
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
