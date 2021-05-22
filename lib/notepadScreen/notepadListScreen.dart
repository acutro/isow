import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import '17_notepad.dart';

class NotepadList extends StatefulWidget {
  // final String email;
  // Contact({Key key, @required this.email}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<NotepadList> {
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Future fetchData() async {
    http.Response response;
    response =
        await http.get('http://isow.acutrotech.com/index.php/api/Notepad/list');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        print("{$listFacts}");
      });
    }
  }

  Future deleteNotepad(
    String id,
  ) async {
    var data = {'id': id};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/delete',
        body: (data));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getColor(String str) {}

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

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
        body: mapResponse == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration:
                    BoxDecoration(color: Color(0xFF4fc4f2).withOpacity(0.2)),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: listFacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final Message chat = chats[index];
                    return GestureDetector(
                      onTap: () {
                        showDialogFunc(
                          context,
                          listFacts[index]["name"],
                          listFacts[index]["date"],
                          listFacts[index]["requirements"],
                          'https://googleflutter.com/sample_image.jpg',
                          listFacts[index]["id"],
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
                                width: MediaQuery.of(context).size.width * 0.90,
                                padding: EdgeInsets.all(3),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Color(0xFF4fc4f2),
                                        child: Text(
                                          listFacts[index]["name"]
                                              .substring(0, 1),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      title: Text(
                                        listFacts[index]["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                      ),
                                      subtitle: Text(
                                        listFacts[index]["date"],
                                      ),
                                      trailing: InkWell(
                                          onTap: () {
                                            deleteNotepad(
                                                listFacts[index]["id"]);
                                            fetchData();
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red[400],
                                          )),
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notepad()),
            );
          },
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: Text("ADD"),
        ),
      ),
    );
  }
}

showDialogFunc(context, title, date, requirment, path, id) {
  Future deleteNotepad(
    String id,
  ) async {
    var data = {'id': id};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Notepad/delete',
        body: (data));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
                                backgroundColor: Color(0xFF4fc4f2),
                                child: Text(
                                  title.substring(0, 1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 1.5),
                              ),
                              trailing: InkWell(
                                  onTap: () {
                                    deleteNotepad(id);

                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[400],
                                  )),
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
                    child: new Text(requirment,
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
