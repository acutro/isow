import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Emergency'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                    height: 150.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  //margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 10.0),
                  child: Image.asset('assets/images/signal.jpg'),
                  height: 150.0,
                  color: Colors.blueGrey,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                    height: 150.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 50.0,
              child: Text(
                'Emergency',
                style: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                        height: 130.0,
                        width: 90.0,
                        child: Container(
                          height: 20.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                  color: Color(0xff49A5FF), width: 2.0)),
                          child: Text(
                            "       911       ",
                            style: TextStyle(
                              color: Color(0xff49A5FF),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff49A5FF),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                        height: 110.0,
                        width: 90.0,
                        child: Center(
                          child: Icon(
                            Icons.local_police,
                            size: 60.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                        height: 105.0,
                        width: 90.0,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Police',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 0.0),
                        height: 130.0,
                        width: 90.0,
                        child: Container(
                          height: 20.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                  color: Color(0xff49A5FF), width: 2.0)),
                          child: Text(
                            "       111       ",
                            style: TextStyle(
                              color: Color(0xff49A5FF),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff49A5FF),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 0.0),
                        height: 110.0,
                        width: 90.0,
                        child: Center(
                          child: Icon(
                            Icons.local_hospital,
                            size: 80.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 0.0),
                        height: 105.0,
                        width: 100.0,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Hospital',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                        height: 130.0,
                        width: 90.0,
                        child: Container(
                          height: 20.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                  color: Color(0xff49A5FF), width: 2.0)),
                          child: Text(
                            "       237       ",
                            style: TextStyle(
                              color: Color(0xff49A5FF),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff49A5FF),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                        height: 110.0,
                        width: 90.0,
                        child: Center(
                          child: Icon(
                            Icons.local_fire_department,
                            size: 80.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 0.0, 20.0, 0.0),
                        height: 105.0,
                        width: 100.0,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Fire',
                          style: TextStyle(color: Colors.white),
                        ),
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
