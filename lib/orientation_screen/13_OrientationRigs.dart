import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'rigDetailpage.dart';

class OrientationRigScreen extends StatefulWidget {
  @override
  _OrientationRigScreenState createState() => _OrientationRigScreenState();
}

class _OrientationRigScreenState extends State<OrientationRigScreen> {
  List rigList;
  Future<List<riglist>> _getRiglist() async {
    var rigData = await http
        .get("http://isow.acutrotech.com/index.php/api/orientation/rigList");
    Map jsonData = json.decode(rigData.body);

    List<riglist> rig = [];
    jsonData["data"].forEach((f) {
      riglist employee = riglist(
        id: f["id"],
        rigId: f["rigId"],
        rigName: f["rigName"],
        details: f["details"],
        path: f["rig_image"],
      );
      rig.add(employee);
      setState(() {
        rigList = jsonData["data"];
      });
    });
    return rig;
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _getRiglist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Orientation Rigs',
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
        child: FutureBuilder(
            future: _getRiglist(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                print(snapshot.data.length);
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ListTile(
                          leading: Image.network(
                            'http://isow.acutrotech.com/assets/images/rigs/' +
                                snapshot.data[index].path,
                            width: 150.0,
                            height: 150.0,
                          ),
                          title: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    snapshot.data[index].rigId,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Text(
                                    snapshot.data[index].rigName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: RaisedButton(
                            color: Color(0xFF4fc4f2),
                            textColor: Colors.white,
                            child: Text('More Details'),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RigDetailScreen(
                                          rigList: rigList,
                                          id: index,
                                          flag: 0,
                                        )),
                              ),
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          )),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}

class riglist {
  final String id;
  final String rigId;
  final String rigName;
  final String details;
  final String path;

  riglist({this.id, this.rigId, this.rigName, this.details, this.path});
}
