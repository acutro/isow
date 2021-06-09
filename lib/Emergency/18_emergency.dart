import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  String sid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;
      fetchIssued(id);
      error = false;
    });
  }

  Future deleteContact(
    String id,
  ) async {
    var data = {
      'id': id,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SOS/delete',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Deleted Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
        Duration(seconds: 1),
        () => fetchIssued(sid),
      );
    } else {
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future upSos(
    String uid,
    String name,
    String content,
  ) async {
    var data = {
      'userId': uid,
      'name': name,
      'sos_content': content,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SOS/create',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("SOS Added Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
        Duration(seconds: 1),
        () => Navigator.pop(context),
      );
    } else {
      Toast.show("Failed try again", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future fetchIssued(String siid) async {
    var data = {
      'userId': siid,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SOS/singleList',
        body: (data));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        jobError = false;
        print("{$listFacts}");
      });
    } else {
      jobError = true;

      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  @override
  void initState() {
    getValidation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff49A5FF),
          title: Text(' Emergency'),
          centerTitle: true,
        ),
        body: jobError == true || mapResponse == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 30.0),
                            height: 100.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.0),
                          //margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 10.0),
                          child: Image.asset('assets/images/signal.jpg'),
                          height: 100.0,
                          color: Colors.blueGrey,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 30.0),
                            height: 100.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40.0,
                      child: Text(
                        'Emergency',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                // margin:
                                //     EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                                height: 130.0,
                                width: 90.0,
                                child: Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                          color: Color(0xff49A5FF),
                                          width: 2.0)),
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
                                // margin:
                                //     EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
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
                                // margin:
                                //     EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
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
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin:
                                    EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
                                height: 130.0,
                                width: 90.0,
                                child: Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                          color: Color(0xff49A5FF),
                                          width: 2.0)),
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
                                margin:
                                    EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
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
                                margin:
                                    EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
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
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                height: 130.0,
                                width: 90.0,
                                child: Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                          color: Color(0xff49A5FF),
                                          width: 2.0)),
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
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
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
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
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
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          child: Icon(
                            Icons.person,
                            size: 70.0,
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
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                height: 50.0,
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                                child: Text(
                                  'SOS Contacts',
                                  style: TextStyle(
                                      fontSize: 25.0, color: Colors.black54),
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: listFacts.length == 0
                          ? Center(child: Text("No SOS added yet"))
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: listFacts.length,
                              itemBuilder: (BuildContext context, int index) {
                                // final Message chat = chats[index];
                                return GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.90,
                                          padding: EdgeInsets.all(3),
                                          child: Column(
                                            children: <Widget>[
                                              ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFF4fc4f2),
                                                  child: Text(
                                                    listFacts[index]["name"]
                                                        .toUpperCase()
                                                        .substring(0, 1),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                title: Text(
                                                  listFacts[index]["name"],
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                subtitle: Text(
                                                    listFacts[index]
                                                        ["sos_content"],
                                                    style: TextStyle(
                                                        fontSize: 14)),
                                                trailing: Container(
                                                  width: 100,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            // BuildAlertDialogDelete();

                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                title: Text(
                                                                    "Delete?"),
                                                                content: Text(
                                                                    "Do you want to delete?"),
                                                                actions: [
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "No")),
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        deleteContact(
                                                                          listFacts[index]
                                                                              [
                                                                              "id"],
                                                                        );
                                                                        fetchIssued(
                                                                            sid);
                                                                      },
                                                                      child: Text(
                                                                          "Yes"))
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color:
                                                                Colors.red[400],
                                                          )),
                                                      InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        onTap: () {
                                                          launch(
                                                            "tel:" +
                                                                listFacts[index]
                                                                    [
                                                                    "sos_content"],
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  18),
                                                          child:
                                                              Icon(Icons.call),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: jobError == true || mapResponse == null
            ? Center()
            : listFacts.length < 3
                ? FloatingActionButton.extended(
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                elevation: 5.0,
                                type: MaterialType.card,
                                child: Container(
                                  padding: EdgeInsets.all(25),
                                  height: 300,
                                  width: 350,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          "Add SOS Contact",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(10),

                                        /// margin: EdgeInsets.all(20.0),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 45.0,
                                        child: TextField(
                                          controller: _nameController,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12),
                                          decoration: new InputDecoration(
                                            hintText: 'SOS Name',
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,

                                        /// margin: EdgeInsets.all(20.0),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 6.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 45.0,
                                        child: TextField(
                                          controller: _numberController,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12),
                                          decoration: new InputDecoration(
                                            hintText: 'SOS Number',
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 120.0,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xff49A5FF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6.0,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            child: Center(
                                              child: Text(
                                                'Add SOS',
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(1.0)),
                                              ),
                                            ),
                                            onTap: () {
                                              if (_nameController.text == "" ||
                                                  _numberController.text ==
                                                      "") {
                                                Toast.show(
                                                    "Enter Name and SOS Number",
                                                    context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM,
                                                    textColor: Colors.blue[600],
                                                    backgroundColor:
                                                        Colors.white);
                                              } else if (_numberController
                                                      .text.length !=
                                                  10) {
                                                Toast.show(
                                                    "Number Must be 10 Digit",
                                                    context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM,
                                                    textColor: Colors.blue[600],
                                                    backgroundColor:
                                                        Colors.white);
                                              } else {
                                                upSos(sid, _nameController.text,
                                                    _numberController.text);
                                                _nameController.text = "";
                                                _numberController.text = "";
                                                getValidation();
                                              }
                                              getValidation();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    label: Text("Add SOS"),
                  )
                : null);
  }
}
