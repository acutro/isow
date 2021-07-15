import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import '15_issuewarning.dart';

class RecivedWarning extends StatefulWidget {
  final String userid;
  final String posid;

  RecivedWarning({Key key, @required this.userid, this.posid})
      : super(key: key);
  @override
  _RecivedWarningState createState() => _RecivedWarningState();
}

class _RecivedWarningState extends State<RecivedWarning> {
  String sid;
  String posiid;
  bool error = true;
  Future getValidation(String nam) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    String pos = sharedPreferences.getString('position');
    setState(() {
      sid = id;
      posiid = pos;
      pos == '4' ? _getsupervisor(id) : _getEmployee(id, nam);
      error = false;
    });
  }

  TextEditingController controller = new TextEditingController();
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future _getEmployee(String id, String namee) async {
    var data = {
      'toId': id,
      'issue': namee,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SearchList/searchWarningLetter',
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

      Toast.show("No Warning Letter Found", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future _getsupervisor(String id) async {
    var data = {
      'fromId': id,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/WarningLetter/supervisorsingleList',
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

      Toast.show("No Warning Letter Found", context,
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

  Timer _clockTimer;
  @override
  void initState() {
    getValidation("");
    super.initState();
    _clockTimer = Timer.periodic(
        Duration(seconds: 6), (Timer t) => getValidation(controller.text));
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
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
        onRefresh: () {
          refreshList(controller.text);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
          height: double.infinity,
          child: Column(
            children: [
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.sticky_note_2,
                    size: 70.0,
                    color: Colors.blue,
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: posiid == '4' ? 'Issued  ' : 'Recieved  ',
                            style: TextStyle(fontSize: 26)),
                        TextSpan(text: 'Warning Letter'),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 1, color: Colors.grey[600])),
                margin:
                    new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    _getEmployee(sid, controller.text);
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
                              _getEmployee(sid, controller.text);
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
                    // filled: true,
                    // fillColor: Colors.white24,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              Expanded(
                child: jobError == true || mapResponse == null
                    ? Center(
                        child: SpinKitChasingDots(
                          color: Colors.blue,
                          size: 120,
                        ),
                      )
                    : listFacts == null
                        ? Center(
                            heightFactor: 10,
                            child: Text("No Warning Letter found"))
                        : ListView.builder(
                            itemCount: listFacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialogFunc(
                                    context,
                                    listFacts[index]['to'],
                                    listFacts[index]['position'],
                                    listFacts[index]['created_at']
                                        .substring(0, 10),
                                    listFacts[index]['content'],
                                    listFacts[index]['issue'],
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 20.0),
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
                                                  color: Colors.blue,
                                                  //color: Color(0xff4fc4f2),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                  )),
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, .0, 0.0),
                                              child: Center(
                                                child: Text(
                                                  listFacts[index]['to'],
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              color: Colors.blue,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              child: Center(
                                                child: Text(
                                                  listFacts[index]['position'],
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              alignment: Alignment.topLeft,
                                              //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                                              child: Center(
                                                child: Text(
                                                  listFacts[index]['created_at']
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    listFacts[index]['issue'],
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
                                                    '${listFacts[index]['content'].toUpperCase()}${listFacts[index]['content'].substring(1)}',
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
          ),
        ),
      ),
      floatingActionButton: widget.posid == '4'
          ? FloatingActionButton.extended(
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
            )
          : null,
    );
  }
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
                                backgroundColor: Colors.blue,
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
