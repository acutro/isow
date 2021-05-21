import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';

class RecivedWarning extends StatefulWidget {
  @override
  _RecivedWarningState createState() => _RecivedWarningState();
}

class _RecivedWarningState extends State<RecivedWarning> {
  Future<List<Warning>> _getEmployee() async {
    var empData = await http
        .get("http://isow.acutrotech.com/index.php/api/WarningLetter/list");
    Map jsonData = json.decode(empData.body);

    List<Warning> employees = [];
    jsonData["data"].forEach((f) {
      Warning employee = Warning(
          id: f["id"],
          position: f["position"],
          person: f["person"],
          content: f["content"],
          created_at: f["created_at"]);
      employees.add(employee);
    });
    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Warning Letter',
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
      body: Container(
        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        height: double.infinity,
        child: FutureBuilder(
            future: _getEmployee(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                print(snapshot.data.length);
                return Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                          child: Icon(
                            Icons.sticky_note_2,
                            size: 90.0,
                            color: Color(0xff4fc4f2),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 40.0, 10.0, 0.0),
                            child: Center(
                              child: TextFormField(
                                cursorColor: Theme.of(context).cursorColor,
                                //initialValue: 'Opinion and Issue?',
                                maxLength: 20,
                                decoration: InputDecoration(
                                  // icon: Icon(Icons.favorite),
                                  labelText: 'Recived',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    //color: Color(0xff49A5FF),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff4fc4f2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
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
                            height: 230.0,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                            color: Color(0xff4fc4f2),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                            )),
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 0.0, .0, 0.0),
                                        child: Center(
                                          child: Text(
                                            snapshot.data[index].position,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 2.0,
                                      height: 40.0,
                                      color: Colors.black54,
                                      //margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 40.0,
                                        color: Color(0xff4fc4f2),
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: Center(
                                          child: Text(
                                            snapshot.data[index].person,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 2.0,
                                      height: 40.0,
                                      color: Colors.black54,
                                      // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xff4fc4f2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        alignment: Alignment.topLeft,
                                        //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                                        child: Center(
                                          child: Text(
                                            snapshot.data[index].id,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        child:
                                            Text(snapshot.data[index].content),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                                  alignment: Alignment.centerLeft,
                                  height: 20.0,
                                  child: Text(snapshot.data[index].created_at),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}

class Warning {
  final String id;
  final String position;
  final String person;
  final String content;
  final String created_at;

  Warning({this.id, this.position, this.person, this.content, this.created_at});
}
