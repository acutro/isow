import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class WeatherreportScreen extends StatefulWidget {
  @override
  WeatherreportScreenState createState() => WeatherreportScreenState();
}

class WeatherreportScreenState extends State<WeatherreportScreen> {
  bool maperror = false;
  Map mapResponse;
  List<dynamic> wheatherList;
  double lat;
  double long;
  String pin;
  String country;

  getLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      long = geoposition.longitude;
      lat = geoposition.latitude;
      getAddresslocation(long, lat);
    });
  }

  getAddresslocation(double longi, double lati) async {
    final cordinates = new Coordinates(lati, longi);
    var address = await Geocoder.local.findAddressesFromCoordinates(cordinates);
    setState(() {
      pin = address.first.postalCode.toString();
      country = address.first.countryCode;
      fetchData(address.first.postalCode.toString(), address.first.countryCode);
    });
  }

  Future fetchData(String pinn, String countryCode) async {
    http.Response response;
    response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?zip=$pinn,$countryCode&appid=0a681522fa87ca5bc41e86a551d1a80f');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        wheatherList = mapResponse['weather'];

        print("{$wheatherList}");
      });
    } else {
      setState(() {
        maperror = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  // Final api =
  //     'http://api.openweathermap.org/data/2.5/weather?zip=676552,in&appid=0a681522fa87ca5bc41e86a551d1a80f';

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
      body: mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(5.0, 50.0, 30.0, 3.0),
                          height: 100.0,
                          child: Text(
                            'Notification',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 30.0, 30.0, 3.0),
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
                                  padding:
                                      EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
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
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      mapResponse['name'],
                                      // 'Middle East',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.fromLTRB(
                                          30.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        (mapResponse['main']['temp'] - 273.15)
                                                .toInt()
                                                .toString() +
                                            "\u2103",
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
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      wheatherList[0]['description'],
                                      // 'Light Cloud',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
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
                          child: GestureDetector(
                            onTap: () {
                              getLocation();
                              Toast.show(
                                "Updated",
                                context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM,
                                backgroundColor: Colors.white,
                                textColor: Colors.green[400],
                              );
                            },
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
                                    (mapResponse['main']['temp'] - 273.15)
                                        .toInt()
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ],
                            ),
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

// child: Center(
//   child: Text(
//     'changing weather going to future 3 days ?',
//     style: TextStyle(
//       color: Colors.white,
//     ),
//   ),
