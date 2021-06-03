import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import '14_feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackList extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<FeedbackList> {
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
        'http://isow.acutrotech.com/index.php/api/Feedback/singleList',
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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    getValidation();
  }

  @override
  void initState() {
    getValidation();

    super.initState();
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
            color: Colors.white38,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.logout,
            color: Colors.white38,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.menu,
            color: Colors.white38,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: jobError == true || mapResponse == null
            ? Center(
                child: CircularProgressIndicator(),
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
                                listFacts[index]["created_at"],
                                listFacts[index]["content"],
                              );
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      padding: EdgeInsets.all(3),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xFF4fc4f2),
                                              child: Text(
                                                'F',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            title: Text(
                                              "Feedback",
                                              // '${listFacts[index]["created_at"][0].toUpperCase()}${listFacts[index]["created_at"].substring(1)}',
                                              //  listFacts[index]["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5),
                                            ),
                                            subtitle: Text(
                                              listFacts[index]["content"]
                                                          .length >
                                                      40
                                                  ? listFacts[index]["content"]
                                                      .substring(0, 40)
                                                  : listFacts[index]["content"],
                                            ),
                                            trailing: Text(
                                              listFacts[index]["created_at"]
                                                  .substring(0, 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
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

showDialogFunc(context, date, description) {
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
            height: 400,
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
                                'Feedback',
                                // title,
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
                  flex: 1,
                  child: new SingleChildScrollView(
                    //  padding: EdgeInsets.all(8),
                    scrollDirection: Axis.vertical, //.horizontal
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
