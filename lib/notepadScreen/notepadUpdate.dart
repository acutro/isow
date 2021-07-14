import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'notepadListScreen.dart';
import 'package:toast/toast.dart';

class UpdateNotepad extends StatefulWidget {
  final String id;
  final String userId;
  final String name;
  final String requirment;
  final String date;
  final String pr;

  UpdateNotepad(
      {Key key,
      @required this.id,
      this.userId,
      this.name,
      this.requirment,
      this.date,
      this.pr})
      : super(key: key);
  @override
  _NotepadState createState() => _NotepadState();
}

class _NotepadState extends State<UpdateNotepad> {
  int pr = 0;
  Future updateNotepad(
    String id,
    String userid,
    String name,
    String requirment,
    String date,
    String pr,
    String prio,
    String cato,
  ) async {
    var data = {
      'id': id,
      'userId': userid,
      'name': name,
      'requirements': requirment,
      'date': date,
      'priorityColor': pr,
      'priority': prio,
      'category_id': cato
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/update',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Updated Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotepadList()),
              ));
    } else {
      Toast.show("Enter valid credentials", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  List<dynamic> catList;
  Future fetchCat() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/Notepad/categorylist');
    if (response.statusCode == 200) {
      setState(() {
        catResponse = jsonDecode(response.body);
        catList = catResponse['data'];
        print("{$catList}");
      });
    }
  }

  TextEditingController catoController = new TextEditingController();
  int catValue;
  bool catError = false;
  Map catResponse;
  Future addCat(String catName) async {
    var data = {
      'categoryName': catName,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/categorycreate',
        body: (data));
    if (response.statusCode == 200) {
      // Toast.show("Status changed Successfully", context,
      //     duration: Toast.LENGTH_SHORT,
      //     gravity: Toast.BOTTOM,
      //     textColor: Colors.green[600],
      //     backgroundColor: Colors.white);
      Timer(Duration(seconds: 1), () => fetchCat());
    } else {
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  bool prError = false;
  int prValue;
  List prList = [
    {'priority': 'Severe', 'id': '1'},
    {'priority': 'Moderate', 'id': '2'},
    {'priority': 'Important', 'id': '3'}
  ];
  Widget prioDrop() {
    return DropdownButton(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      iconEnabledColor: Colors.white,
      value: prValue,
      style: TextStyle(color: Colors.white),
      isExpanded: true,
      dropdownColor: Color(0xff49A5FF),
      underline: Container(
        height: 0,
        color: prError ? Colors.red : Colors.white,
      ),
      hint: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Select Priority",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontFamily: "WorkSansLight"),
        ),
      ),
      items: (prList).map<DropdownMenuItem>((answer) {
        return DropdownMenuItem(
          value: int.parse(answer["id"]),
          child: Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              answer["priority"],
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          prError = false;
          prValue = value;

          print("$prValue id of compny");
        });
        // print(companyValue.runtimeType);
      },
    );
  }

  Widget buildRoleDropDownButton() {
    return DropdownButton(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      iconEnabledColor: Colors.white,
      value: catValue,
      style: TextStyle(color: Colors.white),
      isExpanded: true,
      dropdownColor: Color(0xff49A5FF),
      underline: Container(
        height: 0,
        color: catError ? Colors.red : Colors.white,
      ),
      hint: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Select Catogory",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontFamily: "WorkSansLight"),
        ),
      ),
      items: (catList).map<DropdownMenuItem>((answer) {
        return DropdownMenuItem(
          value: int.parse(answer["id"]),
          child: Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              answer["categoryName"],
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          catError = false;
          catValue = value;

          print("$catValue id of compny");
        });
        // print(companyValue.runtimeType);
      },
    );
  }

  _addAlert() {
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
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 230,
              width: 320,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(18),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Catogory Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.topLeft,

                    /// margin: EdgeInsets.all(20.0),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),

                    child: TextField(
                      textAlign: TextAlign.start,
                      maxLines: null,
                      controller: catoController,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      decoration: new InputDecoration(
                        hintText: 'Catogory',
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
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0),
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
                            'Add',
                            style:
                                TextStyle(color: Colors.white.withOpacity(1.0)),
                          ),
                        ),
                        onTap: () {
                          if (catoController.text == "") {
                            Toast.show("Enter Catogory", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM,
                                textColor: Colors.blue[600],
                                backgroundColor: Colors.white);
                          } else {
                            addCat(catoController.text);

                            fetchCat();
                            Timer(
                              Duration(seconds: 1),
                              () => Navigator.pop(context),
                            );
                            fetchCat();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    date1 = widget.date;

    _nameController.text = widget.name;
    _requirmentController.text = widget.requirment;
    fetchCat();
  }

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _requirmentController = new TextEditingController();
  DateTime _datetime;
  String date1;
  var Rowno = 3;
  List<int> rowno = [1, 1, 1];

  Row createrow(TextEditingController tcontrol) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            height: 40.0,
            child: TextField(
              controller: tcontrol,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // date1 = widget.date;

    // _nameController.text = widget.name;
    // _requirmentController.text = widget.requirment;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Notepad'),
        centerTitle: true,
      ),
      body: catResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    height: 50.0,
                    child: Center(
                        child: Text(
                      'Update Notepad',
                      style: TextStyle(fontSize: 28, color: Colors.black54),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    height: 20.0,
                    //width: double.infinity,
                    child: Text(
                      '"Note down or feed all the day activities & Requirements"',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 10.0),
                          height: 1.0,
                          color: Color(0xff49A5FF),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 10.0),
                        //height: 1.0,
                        child: Icon(
                          Icons.adb_outlined,
                          color: Color(0xff49A5FF),
                        ),
                        //color: Color(0xff4fc4f2),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 20.0, 20.0, 10.0),
                          height: 1.0,
                          color: Color(0xff49A5FF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                            decoration: BoxDecoration(
                              color: Color(0xff49A5FF),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            margin: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 5.0, 0.0),
                                            height: 40.0,
                                            child: ElevatedButton(
                                                child: Text(
                                                  _datetime == null
                                                      ? date1.substring(0, 10)
                                                      : _datetime
                                                          .toString()
                                                          .substring(0, 10),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  primary: Color(0xff49A5FF),
                                                ),
                                                onPressed: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        _datetime == null
                                                            ? DateTime.now()
                                                            : _datetime,
                                                    firstDate: DateTime(2001),
                                                    lastDate: DateTime(2222),
                                                  ).then((date) {
                                                    setState(() {
                                                      _datetime = date;
                                                    });
                                                  });
                                                })),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Color(0xff49A5FF),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.fromLTRB(
                                              10.0, 10.0, 10.0, 0.0),
                                          height: 40.0,
                                          child: TextField(
                                            controller: _nameController,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              hintText: 'Title',
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            margin: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 5.0, 0.0),
                                            height: 40.0,
                                            child: buildRoleDropDownButton()),
                                      ),
                                      GestureDetector(
                                        onTap: _addAlert,
                                        child: Container(
                                          width: 70,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Color(0xff49A5FF),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.fromLTRB(
                                              10.0, 10.0, 10.0, 0.0),
                                          height: 40.0,
                                          child: Text(
                                            "Add",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 5.0, 0.0),
                                      height: 40.0,
                                      child: prioDrop()),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 2.0, 10.0, 10.0),
                                    width: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        // Container(
                                        //   alignment: Alignment.topLeft,
                                        //   margin: EdgeInsets.fromLTRB(
                                        //       10.0, 10.0, 0.0, 0.0),
                                        //   child: Text(
                                        //     'Priority',
                                        //     style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: 16.0,
                                        //         fontWeight: FontWeight.bold),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                          ),
                                          alignment: Alignment.center,
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            spacing: 15.0,
                                            runSpacing: 10.0,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    pr = 1;
                                                  });
                                                },
                                                child: Container(
                                                  height: pr == 1 ? 40 : 30,
                                                  width: pr == 1 ? 50 : 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      border: Border.all(
                                                          width: 3,
                                                          color:
                                                              Colors.white54)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    pr = 2;
                                                  });
                                                },
                                                child: Container(
                                                  height: pr == 2 ? 40 : 30,
                                                  width: pr == 2 ? 50 : 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      border: Border.all(
                                                          width: 3,
                                                          color:
                                                              Colors.white54)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    pr = 3;
                                                  });
                                                },
                                                child: Container(
                                                  height: pr == 3 ? 40 : 30,
                                                  width: pr == 3 ? 50 : 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      border: Border.all(
                                                          width: 3,
                                                          color:
                                                              Colors.white54)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    pr = 4;
                                                  });
                                                },
                                                child: Container(
                                                  height: pr == 4 ? 40 : 30,
                                                  width: pr == 4 ? 50 : 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      border: Border.all(
                                                          width: 3,
                                                          color:
                                                              Colors.white54)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    pr = 5;
                                                  });
                                                },
                                                child: Container(
                                                  height: pr == 5 ? 40 : 30,
                                                  width: pr == 5 ? 50 : 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    border: Border.all(
                                                        width: 3,
                                                        color: Colors.white54),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 2.0, 10.0, 10.0),
                                    height: 230.0,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.fromLTRB(
                                              11.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'Requirments',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff49A5FF),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: Colors.white)),
                                            margin: EdgeInsets.all(10.0),
                                            child: new TextField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                              ),
                                              autofocus: false,
                                              maxLines: 8,
                                              controller: _requirmentController,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (pr == 0 || catValue == 0 || prValue == 0) {
                              Toast.show("Select Priority Updations", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM,
                                  textColor: Colors.red,
                                  backgroundColor: Colors.white);
                            } else if (_datetime == null) {
                              updateNotepad(
                                  widget.id,
                                  widget.userId,
                                  _nameController.text,
                                  _requirmentController.text,
                                  widget.date.substring(0, 10) +
                                      " 00:00:00.000",
                                  pr.toString(),
                                  prValue.toString(),
                                  catValue.toString());
                            } else {
                              updateNotepad(
                                  widget.id,
                                  widget.userId,
                                  _nameController.text,
                                  _requirmentController.text,
                                  _datetime.toString(),
                                  pr.toString(),
                                  prValue.toString(),
                                  catValue.toString());
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 0.0, 2.5, 0.0),
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Color(0xff4fc4f2),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotepadList()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(2.5, 0.0, 20.0, 0.0),

                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Color(0xff4fc4f2),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}
