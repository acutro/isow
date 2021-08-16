import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:isow/Widgects/alertBox.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import '14_feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FeedbackList extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<FeedbackList> {
  String sid;
  bool loading = true;
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

  Future deletefeedback(String feedId) async {
    var data = {
      'id': feedId,
    };
    http.Response response;
    response = await http.post(ApifeedbackNews.feedBackDeleteApi, body: (data));
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      Toast.show("Feedback Deleted Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(Duration(seconds: 2), () => fetchIssued(sid));
    } else {
      setState(() {
        loading = false;
      });
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future fetchIssued(String siid) async {
    var data = {
      'userId': siid,
    };
    http.Response response;
    response = await http.post(ApifeedbackNews.feedBackListApi, body: (data));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        jobError = false;
        loading = true;
        print("{$listFacts}");
      });
    } else {
      setState(() {
        loading = true;
        jobError = true;
      });

      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    getValidation();
  }

  Timer _clockTimer;
  @override
  void initState() {
    getValidation();

    super.initState();
    _clockTimer =
        Timer.periodic(Duration(seconds: 6), (Timer t) => getValidation());
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedback",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Icon(
            Icons.headset_mic,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              return showDialog(
                  context: context,
                  builder: (context) => BuildLogoutDialogclose(sid));
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
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
        child: jobError == true || mapResponse == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                decoration:
                    BoxDecoration(color: Color(0xFF4fc4f2).withOpacity(0.2)),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: listFacts.length == 0
                    ? Center(child: Text("No Feedback found"))
                    : ListView.builder(
                        itemCount: listFacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              showDialogFunc(
                                context,
                                listFacts[index]["opinion"],
                                listFacts[index]["created_at"],
                                listFacts[index]["content"],
                                listFacts[index]["replied_message"],
                              );
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              'F',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          title: Text(
                                            listFacts[index]["opinion"].length >
                                                    21
                                                ? listFacts[index]["opinion"]
                                                    .substring(0, 21)
                                                : listFacts[index]["opinion"],
                                            // '${listFacts[index]["created_at"][0].toUpperCase()}${listFacts[index]["created_at"].substring(1)}',
                                            //  listFacts[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.5),
                                          ),
                                          subtitle: Text(
                                            listFacts[index]["content"].length >
                                                    40
                                                ? listFacts[index]["content"]
                                                    .substring(0, 40)
                                                : listFacts[index]["content"],
                                          ),
                                          trailing: Column(
                                            children: [
                                              Text(
                                                listFacts[index]["created_at"]
                                                    .substring(0, 10),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    // BuildAlertDialogDelete();

                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        title: Text("Delete?"),
                                                        content: Text(
                                                            "Do you want to delete?"),
                                                        actions: [
                                                          FlatButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text("No")),
                                                          FlatButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                if (loading ==
                                                                    true) {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      content:
                                                                          Container(
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            CircularProgressIndicator(
                                                                              color: Colors.red,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                  Timer(
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                                    () => deletefeedback(
                                                                        listFacts[index]
                                                                            [
                                                                            "id"]),
                                                                  );
                                                                  fetchIssued(
                                                                      sid);
                                                                }
                                                              },
                                                              child:
                                                                  Text("Yes"))
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[400],
                                                  )),
                                            ],
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FeedbackCounter(
                      userId: sid,
                    )),
          );
        },
        icon: Icon(
          Icons.add,
          size: 30,
        ),
        label: Text("Feedback"),
      ),
    );
  }
}

showDialogFunc(context, opinion, date, description, replay) {
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
            height: 500,
            width: 350,
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
                                  'F',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                opinion.length > 60
                                    ? opinion.substring(0, 60)
                                    : opinion,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 1.5),
                              ),
                              subtitle: Text(
                                date,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                              // trailing: InkWell(
                              //     onTap: () {
                              //       Navigator.pop(context);
                              //     },
                              //     child: Icon(
                              //       Icons.delete,
                              //       color: Colors.red[400],
                              //     )),
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
                  flex: 4,
                  child: SingleChildScrollView(
                    child: new Text(
                        '${description[0].toUpperCase()}${description.substring(1)}',
                        // requirment,
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                ),
                replay != ""
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black38),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.centerLeft,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reply:",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Expanded(
                              child: Text(
                                replay,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 30,
                        child: Text(
                          ' OK ',
                          style: TextStyle(color: Colors.white),
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
