import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import '15_issuewarning.dart';

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
          issue: f["issue"],
          position: f["position"],
          person: f["to"],
          content: f["content"],
          createdAt: f["created_at"]);
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
                                child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Recieved ',
                                      style: TextStyle(fontSize: 24)),
                                  TextSpan(text: 'Warning Letter'),
                                ],
                              ),
                            )),
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
                                            snapshot.data[index].createdAt
                                                .substring(0, 10),
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
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5.0),
                                            child: Text(
                                              snapshot.data[index].issue,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5),
                                            ),
                                          ),
                                          Divider(),
                                          Container(
                                            margin: EdgeInsets.all(10.0),
                                            child: Text(
                                              snapshot.data[index].content,
                                              style: TextStyle(
                                                  fontSize: 13, height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin:
                                //       EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                                //   alignment: Alignment.centerLeft,
                                //   height: 20.0,
                                //   child: Text(snapshot.data[index].createdAt),
                                // ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Warningletter()),
          );
        },
        icon: Icon(
          Icons.add,
          size: 30,
        ),
        label: Text("ADD"),
      ),
    );
  }
}

class Warning {
  final String id;
  final String position;
  final String issue;
  final String person;
  final String content;
  final String createdAt;

  Warning(
      {this.id,
      this.position,
      this.issue,
      this.person,
      this.content,
      this.createdAt});
}
