import 'dart:async';
import 'dart:ui';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'alertList.dart';
import 'package:flutter/material.dart';
import 'sizeadjust.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';

class RigAlert2 extends StatefulWidget {
  final String userId;

  RigAlert2({Key key, @required this.userId}) : super(key: key);
  @override
  _RigAlert2State createState() => _RigAlert2State();
}

class _RigAlert2State extends State<RigAlert2> {
  TextEditingController _rigNameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  DateTime _datetime;
  TimeOfDay time;
  Future upAlert(
    String userIdd,
    String rigName,
    String desc,
    String date,
    String timmme,
  ) async {
    String updatte = date + " " + timmme;
    var data = {
      'created_by': userIdd,
      'rigId': rigName,
      'description': desc,
      'date': updatte,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Rigalert/create',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Added Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RecivedAlert()),
              ));
    } else {
      Toast.show("Enter valid credentials", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  List<String> rigNameList = [];
  String rigName;
  Widget buildRigDropDownn() {
    return DropDownField(
      onValueChanged: (dynamic value) {
        setState(() {
          rigName = value;
        });
      },

      strict: true,
      itemsVisibleInDropdown: 5,
      hintStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 14.0),
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 14.0),
      value: rigName,
      // required: false,
      hintText: 'Select Rig Name',
      items: rigNameList,
    );
  }

  rigAlertFn(List rigListt) {
    for (int i = 0; i < rigListt.length; i++) {
      setState(() {
        rigNameList.add(rigListt[i]['rigName']);
      });
    }
  }

  String rigStatusFn(String rigNamepass) {
    String id;
    for (int i = 0; i < rigList.length; i++) {
      if (rigList[i]['rigName'] == rigNamepass) {
        setState(() {
          id = rigList[i]['id'].toString();
        });
      }
    }
    return id;
  }

  _pickTime(TimeOfDay timme) async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: timme);
    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }

  int rigValue;
  bool rigError = false;

  Map mapResponse;
  List<dynamic> rigList;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/orientation/rigList');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        rigList = mapResponse['data'];
        rigAlertFn(rigList);
        print("{$rigList}");
      });
    }
  }

  Widget buildDropDownButton() {
    return Container(
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: DropdownButton(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        iconEnabledColor: Colors.black54,
        value: rigValue,
        // isExpanded: true,
        underline: Container(
          height: 0,
          color: rigError ? Colors.red : Colors.white,
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Rig Name",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        items: (rigList).map<DropdownMenuItem>((answer) {
          return DropdownMenuItem(
            value: int.parse(answer["id"]),
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                answer["rigName"],
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            rigError = false;
            rigValue = value;

            print("$rigValue id of compny");
          });
          // print(companyValue.runtimeType);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rig Alert',
            style: TextStyle(fontSize: 15),
          ),
        ),
        actions: [
          Icon(Icons.headset_mic),
          SizedBox(
            width: 10,
          ),

          Icon(Icons.logout),
          // Icon(Icons.more_vert),
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

      body: mapResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 100.0,
                  //width: double.infinity,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/scn1.PNG',
                      fit: BoxFit.cover,
                    ),
                    subtitle: Text(
                      "Rig Alert",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                      child: buildRigDropDownn()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                    //   alignment: Alignment.topLeft,
                    //   child: buildRigDropDownn(),
                    //   width: SizeConfig.safeBlockHorizontal * 40,
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    // ),

                    //SizedBox( height:SizeConfig.safeBlockVertical * 5),

                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                      child: ElevatedButton(
                          child: Text(
                            _datetime == null
                                ? "Pick Date & Time"
                                // DateTime.now().toString().substring(0, 16)

                                : _datetime.toString().substring(0, 10) +
                                    " : " +
                                    time.toString().substring(10, 15),
                            style: TextStyle(color: Colors.black54),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _datetime == null
                                  ? DateTime.now()
                                  : _datetime,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2222),
                            ).then((date) {
                              setState(() {
                                _datetime = date;
                                _pickTime(time);
                              });
                            });
                          }),
                      width: SizeConfig.safeBlockHorizontal * 40,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                      alignment: Alignment.topLeft,
                      child: TextField(
                        maxLines: 10,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: "Description",
                          // hintText: 'Enter Your Name',
                        ),
                      ),
                      height: SizeConfig.safeBlockVertical * 30,
                      width: SizeConfig.safeBlockHorizontal * 90,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                      // alignment: Alignment.topLeft,
                      child: RaisedButton(
                        onPressed: () {
                          if (rigName == null ||
                              _descriptionController.text == "") {
                            Toast.show("Enter all Details", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM,
                                textColor: Color(0xff49A5FF),
                                backgroundColor: Colors.white);
                          } else if (_datetime == null) {
                            Toast.show("Pick date and Time", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM,
                                textColor: Color(0xff49A5FF),
                                backgroundColor: Colors.white);
                          } else {
                            upAlert(
                                widget.userId,
                                rigStatusFn(rigName),
                                _descriptionController.text,
                                _datetime.toString().substring(0, 10),
                                time.toString().substring(10, 15));
                            _rigNameController.text = "";
                            _descriptionController.text = "";
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF4fc4f2), Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 100.0, minHeight: 40.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Send ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
    );
  }
}
