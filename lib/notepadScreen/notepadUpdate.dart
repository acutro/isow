import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'notepadListScreen.dart';
import 'package:toast/toast.dart';

class UpdateNotepad extends StatefulWidget {
  final String id;
  final String userId;
  final String name;
  final String requirment;
  final String date;

  UpdateNotepad(
      {Key key,
      @required this.id,
      this.userId,
      this.name,
      this.requirment,
      this.date})
      : super(key: key);
  @override
  _NotepadState createState() => _NotepadState();
}

class _NotepadState extends State<UpdateNotepad> {
  Future updateNotepad(
    String id,
    String userid,
    String name,
    String requirment,
    String date,
  ) async {
    var data = {
      'id': id,
      'userId': userid,
      'name': name,
      'requirements': requirment,
      'date': date,
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
    date1 = widget.date;
    _nameController.text = widget.name;
    _requirmentController.text = widget.requirment;
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
      body: SingleChildScrollView(
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
                      height: 300.0,
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: Color(0xff49A5FF),
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
                                        border:
                                            Border.all(color: Colors.white)),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 0.0),
                                    height: 40.0,
                                    child: TextField(
                                      controller: _nameController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Title',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
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
                                          border:
                                              Border.all(color: Colors.white)),
                                      margin: EdgeInsets.all(10.0),
                                      child: new TextField(
                                        style: TextStyle(color: Colors.white),
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10.0),
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
                      if (_datetime == null) {
                        updateNotepad(
                            widget.id,
                            widget.userId,
                            _nameController.text,
                            _requirmentController.text,
                            widget.date.substring(6, 10) +
                                widget.date.substring(2, 6) +
                                widget.date.substring(0, 2) +
                                " 00:00:00.000");
                      } else {
                        updateNotepad(
                            widget.id,
                            widget.userId,
                            _nameController.text,
                            _requirmentController.text,
                            _datetime.toString());
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
                        MaterialPageRoute(builder: (context) => NotepadList()),
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
          ],
        ),
      ),
    );
  }
}
