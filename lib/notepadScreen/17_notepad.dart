import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'notepadListScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notepad extends StatefulWidget {
  @override
  _NotepadState createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  Future upNotepad(
    String name,
    String requirment,
    String date,
  ) async {
    var data = {
      'userId': "aa",
      'name': name,
      'requirements': requirment,
      'date': date,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/create',
        body: (data));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Enter valid credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _requirmentController = new TextEditingController();

  var Rowno = 3;
  List<int> rowno = [1, 1, 1];

  DateTime _datetime;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Notepad'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 50.0,
              child: Center(
                  child: Text(
                'Notepad',
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
                                          10.0, 5.0, 5.0, 0.0),
                                      height: 40.0,
                                      child: ElevatedButton(
                                          child: Text(
                                            _datetime == null
                                                ? "Date"
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
                                          })

                                      // child: TextField(
                                      //   decoration: InputDecoration(
                                      //     hintText: _datetime == null
                                      //         ? "date"
                                      //         : _datetime.toString(),
                                      //     hintStyle:
                                      //         TextStyle(color: Colors.white),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(10.0)),
                                      //       borderSide:
                                      //           BorderSide(color: Colors.white),
                                      //     ),
                                      //   ),
                                      // ),
                                      ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 0.0),
                                    height: 40.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'ID',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
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
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 5.0, 0.0),
                                    height: 40.0,
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 0.0),
                                    height: 40.0,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Position',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
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
                                  child: Container(
                                    height: 40.0,
                                    margin: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 0.0),
                                    //alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      color: Color(0xff49A5FF),
                                      borderRadius: BorderRadius.circular(50.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6.0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            '  Requirements',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                            child: Row(
                                          children: <Widget>[
                                            FlatButton(
                                              minWidth: 1.0,
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    rowno.add(1);
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.add_circle_outline_sharp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 10.0,
                                            // ),
                                            FlatButton(
                                              minWidth: 1.0,
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    rowno.remove(1);
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.remove_circle_outline,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            for (var i in rowno)
                              createrow(_requirmentController),
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
                      if (_datetime == "" ||
                          _nameController.text == "" ||
                          _requirmentController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Enter all Details",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        upNotepad(_nameController.text,
                            _requirmentController.text, _datetime.toString());
                        _nameController.text = "";
                        _requirmentController.text = "";
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
                      Navigator.push(
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
                          'View',
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
