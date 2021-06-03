import 'dart:async';
import 'alertList.dart';
import 'package:flutter/material.dart';
import 'sizeadjust.dart';
import 'copy.dart';
import '9_RigAlertsendmsg.dart';
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
      'rigName': rigName,
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

  _pickTime(TimeOfDay timme) async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: timme);
    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
        leading: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Material(
            shape: new CircleBorder(),
          ),
        ),
        actions: [
          Icon(Icons.headset_mic),
          Icon(Icons.logout),
          Icon(Icons.more_vert),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xfffcfafa),
          foregroundColor: Colors.black54,
          mini: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Rigalert()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 100.0,
            //width: double.infinity,
            child: Row(
              children: <Widget>[
                Container(
                  height: 110,
                  // width: 110,
                  margin: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 5.0),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/scn1.PNG',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 10),
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(1.0, 10.0, 0.0, 5.0),
                        child: Text(
                          "COUNT DOWN TIME",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(5.0, 0.1, 5.0, 5.0),
                            //padding: EdgeInsets.all(5),

                            child: Text(''),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                )),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(5.0, 0.1, 5.0, 5.0),
                            //padding: EdgeInsets.all(5),

                            child: Text(''),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                )),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(5.0, 0.1, 5.0, 5.0),
                            //padding: EdgeInsets.all(5),

                            child: Text(''),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                )),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.1, 0.0, 0.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "HOURS      MINUTES      SECONDS",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              // SizedBox(width: 20.0),
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: Text(
                  "RIG NAME",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 40),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  "DATE AND TIME",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: _rigNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'User Name',
                    // hintText: 'Enter Your Name',
                  ),
                ),
                width: SizeConfig.safeBlockHorizontal * 40,
                height: SizeConfig.safeBlockVertical * 5,
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
              //SizedBox( height:SizeConfig.safeBlockVertical * 5),
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black54)),
                child: ElevatedButton(
                    child: Text(
                      _datetime == null
                          ? "Pick Date and Time"
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
                        initialDate:
                            _datetime == null ? DateTime.now() : _datetime,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2222),
                      ).then((date) {
                        setState(() {
                          _datetime = date;
                          _pickTime(time);
                        });
                      });
                    }),

                //  TextField(
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     // labelText: 'User Name',
                //     // hintText: 'Enter Your Name',
                //   ),
                // ),

                width: SizeConfig.safeBlockHorizontal * 40,
                height: SizeConfig.safeBlockVertical * 5,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Description Field",
                    // hintText: 'Enter Your Name',
                  ),
                ),
                height: SizeConfig.safeBlockVertical * 10,
                width: SizeConfig.safeBlockHorizontal * 90,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                // alignment: Alignment.topLeft,
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Colors.blue,
                        )),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "View Rig Alert List",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                // alignment: Alignment.topLeft,
                child: RaisedButton(
                  onPressed: () {
                    if (_rigNameController.text == "" ||
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
                          _rigNameController.text,
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
                      constraints:
                          BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
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
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
            child: Text(
              "ALERTED RIG LIST",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Tables2(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
            // alignment: Alignment.topLeft,
            child: RaisedButton(
              onPressed: () {},
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
                  constraints: BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Alert",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
