import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '17_notepad.dart';
import 'package:toast/toast.dart';
import 'notepadUpdate.dart';

class NotepadList extends StatefulWidget {
  // final String email;
  // Contact({Key key, @required this.email}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<NotepadList> {
  TextEditingController controller = new TextEditingController();
  String sid;
  bool error = true;
  Future getValidation(String nam) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;
      fetchData(id, nam);
      error = false;
    });
  }

  List listResponse;
  Map mapResponse;
  bool jobError = false;
  List<dynamic> listFacts;
  Future fetchData(String id, String name) async {
    var data = {
      'userId': id,
      'name': name,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SearchList/searchNotepad',
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

  String priofn(String pr) {
    if (pr == '1') {
      return 'Severe';
    } else if (pr == '2') {
      return 'Moderate';
    } else {
      return 'Important';
    }
  }

  Color colorSelect(String sColor) {
    if (sColor == '1') {
      return Colors.red;
    } else if (sColor == '2') {
      return Colors.orange;
    } else if (sColor == '3') {
      return Colors.yellow;
    } else if (sColor == '4') {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  Future deleteNotepad(String id, String ssid) async {
    var data = {'id': id};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/delete',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Deleted Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
        Duration(seconds: 1),
        () => fetchData(ssid, ""),
      );
    } else {
      Toast.show("Something went wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future<Null> refreshList(String nam) async {
    await Future.delayed(Duration(seconds: 2));
    getValidation(nam);
  }

  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = 'https://picsum.photos/250?image=9';

      return pathf;
    } else {
      pathf = 'https://picsum.photos/250?image=9';
      return pathf;
    }
  }

  Timer _clockTimer;
  @override
  void initState() {
    super.initState();
    getValidation("");
    _clockTimer = Timer.periodic(
        Duration(seconds: 6), (Timer t) => getValidation(controller.text));
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
          "Notepad",
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
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          refreshList(controller.text);
        },
        child: jobError == true || mapResponse == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border:
                              Border.all(width: 1, color: Colors.grey[600])),
                      margin: new EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        onChanged: (value) {
                          fetchData(sid, controller.text);
                        },
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        controller: controller,
                        decoration: new InputDecoration(
                          suffixIcon: controller.text.isNotEmpty
                              ? new IconButton(
                                  icon: new Icon(Icons.cancel),
                                  onPressed: () {
                                    controller.clear();
                                    fetchData(sid, controller.text);
                                    // providerData.getContacts();
                                    // onSearchTextChanged('');
                                  },
                                )
                              : Icon(Icons.search),

                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Search',

                          // fillColor: Colors.white24,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: listFacts == null
                              ? Center(
                                  heightFactor: 10,
                                  child: Text("No Notepad found"))
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listFacts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // final Message chat = chats[index];
                                    return GestureDetector(
                                      onTap: () {
                                        showDialogFunc(
                                          context,
                                          listFacts[index]["name"],
                                          listFacts[index]["date"],
                                          listFacts[index]["requirements"],
                                          listFacts[index]["id"],
                                          colorSelect(listFacts[index]
                                              ["priorityColor"]),
                                        );
                                      },
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
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
                                                        radius: 30,
                                                        backgroundColor:
                                                            colorSelect(listFacts[
                                                                    index][
                                                                "priorityColor"]),
                                                        child: Text(
                                                          listFacts[index]
                                                                  ["name"]
                                                              .toUpperCase()
                                                              .substring(0, 1),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        '${listFacts[index]["name"][0].toUpperCase()}${listFacts[index]["name"].substring(1)}',
                                                        //  listFacts[index]["name"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1.5),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Priority     :  " +
                                                                priofn(listFacts[
                                                                        index][
                                                                    "priority"]),
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                          ),
                                                          Text(
                                                            "Catogory  :  " +
                                                                    listFacts[index]
                                                                            [
                                                                            "categoryName"]
                                                                        .toString() ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                          ),
                                                          Text(
                                                            "Date          :  " +
                                                                listFacts[index]
                                                                        ["date"]
                                                                    .substring(
                                                                        0, 10),
                                                            style: TextStyle(
                                                                fontSize: 11),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Container(
                                                        width: 70,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  // BuildAlertDialogDelete();

                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      title: Text(
                                                                          "Update ?"),
                                                                      content: Text(
                                                                          "Do you want to Update ?"),
                                                                      actions: [
                                                                        FlatButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text("No")),
                                                                        FlatButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pushReplacement(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => UpdateNotepad(
                                                                                          id: listFacts[index]["id"],
                                                                                          userId: listFacts[index]["userId"],
                                                                                          name: listFacts[index]["name"],
                                                                                          requirment: listFacts[index]["requirements"],
                                                                                          date: listFacts[index]["date"],
                                                                                          pr: listFacts[index]["priorityColor"],
                                                                                        )),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text("Yes"))
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .create_rounded,
                                                                  color: Colors
                                                                          .green[
                                                                      400],
                                                                )),
                                                            InkWell(
                                                                onTap: () {
                                                                  // BuildAlertDialogDelete();

                                                                  showDialog(
                                                                    context:
                                                                        context,
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
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text("No")),
                                                                        FlatButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              deleteNotepad(listFacts[index]["id"], sid);
                                                                              fetchData(sid, "");
                                                                            },
                                                                            child:
                                                                                Text("Yes"))
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red[400],
                                                                )),
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
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Notepad(userId: sid)),
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

showDialogFunc(context, title, date, requirment, id, color) {
  Future deleteNotepad(
    String id,
  ) async {
    var data = {'id': id};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/delete',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Deleted Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
    } else {
      Toast.show("Something went wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

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
                                radius: 30,
                                backgroundColor: color,
                                child: Text(
                                  title.toUpperCase().substring(0, 1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                '${title[0].toUpperCase()}${title.substring(1)}',
                                // title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 1.5),
                              ),
                              subtitle: Text(
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
                        '${requirment[0].toUpperCase()}${requirment.substring(1)}',
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
