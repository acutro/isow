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
    var data = {
      'userId': '13',
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/WarningLetter/singleList',
        body: (data));

    // var empData = await http
    //     .get("http://isow.acutrotech.com/index.php/api/WarningLetter/list");
    Map jsonData = jsonDecode(response.body);

    List<Warning> employees = [];
    jsonData["data"].forEach((f) {
      Warning employee = Warning(
          id: f["id"] ?? "",
          issue: f["issue"] ?? "",
          position: f["position"] ?? "",
          person: f["to"] ?? "",
          content: f["content"] ?? "",
          createdAt: f["created_at"] ?? "");
      employees.add(employee);
    });
    return employees;
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _getEmployee();
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
          SizedBox(
            width: 10,
          ),
          Icon(Icons.logout),
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
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
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
                            return GestureDetector(
                              onTap: () {
                                showDialogFunc(
                                  context,
                                  snapshot.data[index].person,
                                  snapshot.data[index].position,
                                  snapshot.data[index].createdAt
                                      .substring(0, 10),
                                  snapshot.data[index].content,
                                  snapshot.data[index].issue,
                                );
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
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
                                                  topLeft:
                                                      Radius.circular(10.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.5),
                                                ),
                                              ),
                                              Divider(),
                                              Container(
                                                margin: EdgeInsets.all(10.0),
                                                child: Text(
                                                  '${snapshot.data[index].content[0].toUpperCase()}${snapshot.data[index].content.substring(1)}',
                                                  // snapshot.data[index].content,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      height: 1.5),
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

showDialogFunc(context, person, position, date, content, issue) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          type: MaterialType.card,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            width: 350,
            height: 500,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(3),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFF4fc4f2),
                                child: Text(
                                  person.substring(0, 1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                '${person[0].toUpperCase()}${person.substring(1)}',
                                // title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 1.5),
                              ),
                              subtitle: Text(
                                '${issue[0].toUpperCase()}${issue.substring(1)}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                              trailing: Text(
                                date,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    //  padding: EdgeInsets.all(8),
                    scrollDirection: Axis.vertical, //.horizontal
                    child: new Text(
                        '${content[0].toUpperCase()}${content.substring(1)}',
                        // requirment,
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      width: 10.0,
                      height: 10.0,
                    ),
                    new SizedBox(
                      width: 130.0,
                      height: 45.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 30,
                        child: Text(
                          ' OK ',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
