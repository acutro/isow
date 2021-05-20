import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherreportScreen extends StatefulWidget {
  @override
  WeatherreportScreenState createState() => WeatherreportScreenState();
}

class WeatherreportScreenState extends State<WeatherreportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Weather Report',
          ),
        ),
        actions: [
          Icon(Icons.headset_mic),
          Icon(Icons.logout),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xffF7A940),
                    Color(0xffFEBC32),
                    Color(0xff47BED8),
                    Color(0xff36B9EA)
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 0.0),
                    height: 100.0,
                    child: Text(
                      'Weather',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(5.0, 50.0, 30.0, 3.0),
                    height: 100.0,
                    child: Text(
                      'Notification',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(5.0, 30.0, 30.0, 3.0),
                          height: 100.0,
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.notifications_none_outlined,
                            size: 90.0,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 20.0,
                          right: 10.0,
                          child: Container(
                            //color: Colors.white,
                            child: Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.white,
                              size: 60.0,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 32.0,
                          right: 30.0,
                          child: Container(
                            //color: Colors.white,
                            child: Text(
                              '1',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
                      height: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                            child: Icon(
                              Icons.wb_sunny_rounded,
                              color: Colors.white,
                              size: 100,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Middle East',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  '50',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(30.0, 5.0, 0.0, 0.0),
                              child: Text(
                                'Light Cloud',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Icon(
                              Icons.loop_outlined,
                              size: 180,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 55.0),
                          child: Center(
                              child: Text(
                            '24',
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50.0,
                      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        //color: Color(0xff49A5FF),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Center(
                        child: Text(
                          'changing weather going to future 3 days ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
