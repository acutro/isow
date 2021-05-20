import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text(' offer'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                height: 330.0,
                width: 330.0,
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 50.0,
                      left: 50.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            height: 80.0,
                            width: 80.0,
                            child: Image.asset('assets/images/health.png'),
                          ),
                          Container(
                            //margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            height: 100.0,
                            width: 80.0,
                            alignment: Alignment.bottomCenter,
                            child: Text('Health'),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 50.0,
                        right: 50.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              height: 80.0,
                              width: 80.0,
                              child: Image.asset('assets/images/plane.png'),
                            ),
                            Container(
                              //margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              height: 100.0,
                              width: 80.0,
                              alignment: Alignment.bottomCenter,
                              child: Text('Travel'),
                            ),
                          ],
                        )),
                    Positioned(
                        bottom: 50.0,
                        left: 50.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              height: 80.0,
                              width: 80.0,
                              child: Image.asset('assets/images/shopping.png'),
                            ),
                            Container(
                              //margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              height: 100.0,
                              width: 80.0,
                              alignment: Alignment.bottomCenter,
                              child: Text('Shopping'),
                            ),
                          ],
                        )),
                    Positioned(
                      bottom: 50.0,
                      right: 50.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            height: 80.0,
                            width: 80.0,
                            child: Image.asset('assets/images/food.png'),
                          ),
                          Container(
                            //margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            height: 100.0,
                            width: 80.0,
                            alignment: Alignment.bottomCenter,
                            child: Text('Food'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
