import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'offerListing.dart';
import 'offerListingMain.dart';

class OfferMainScreen extends StatefulWidget {
  @override
  _OfferMainScreenState createState() => _OfferMainScreenState();
}

class _OfferMainScreenState extends State<OfferMainScreen> {
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Future fetchData() async {
    http.Response response;
    response =
        await http.get('http://isow.acutrotech.com/index.php/api/Offers/list');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        print("{$listFacts}");
      });
    }
  }

  List<dynamic> chooseCtogory(List<dynamic> listt, String id) {
    List lis = listt.where((o) => o['category_id'] == id).toList();
    return lis;
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Offers'),
        centerTitle: true,
      ),
      body: mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsListingMain(
                                                offerList: chooseCtogory(
                                                    listFacts, '1'),
                                                path:
                                                    'assets/images/health.png',
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    height: 80.0,
                                    width: 80.0,
                                    child:
                                        Image.asset('assets/images/health.png'),
                                  ),
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsListingMain(
                                                  offerList: chooseCtogory(
                                                      listFacts, '2'),
                                                  path:
                                                      'assets/images/plane.png',
                                                )),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      height: 80.0,
                                      width: 80.0,
                                      child: Image.asset(
                                          'assets/images/plane.png'),
                                    ),
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsListingMain(
                                                  offerList: chooseCtogory(
                                                      listFacts, '3'),
                                                  path:
                                                      'assets/images/shopping.png',
                                                )),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      height: 80.0,
                                      width: 80.0,
                                      child: Image.asset(
                                          'assets/images/shopping.png'),
                                    ),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsListingMain(
                                                offerList: chooseCtogory(
                                                    listFacts, '4'),
                                                path: 'assets/images/food.png',
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    height: 80.0,
                                    width: 80.0,
                                    child:
                                        Image.asset('assets/images/food.png'),
                                  ),
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
