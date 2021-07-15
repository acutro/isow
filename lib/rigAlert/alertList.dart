import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'page8rigalert.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';

class RecivedAlert extends StatefulWidget {
  @override
  _RecivedWarningState createState() => _RecivedWarningState();
}

class _RecivedWarningState extends State<RecivedAlert> {
  CountdownTimerController controllerCount;
  TextEditingController controller = new TextEditingController();
  int endTime = DateTime.now().millisecondsSinceEpoch + 100000000 * 30;
  String sid;
  String posid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    String pos = sharedPreferences.getString('position');
    setState(() {
      sid = id;
      posid = pos;

      error = false;
    });
  }

  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = 'https://picsum.photos/250?image=9';

      return pathf;
    } else {
      pathf = 'http://isow.acutrotech.com/assets/profilepic/' + path;
      return pathf;
    }
  }

  Future deleterig(String rigid) async {
    var data = {
      'id': rigid,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/rigalert/delete',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Rig alert Deleted Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(Duration(seconds: 2), () => _rigList(""));
    } else {
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
  Future _rigList(String namee) async {
    var data = {
      'rigName': namee,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SearchList/searchRigalert',
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

      Toast.show("No Rig Alerts found", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future<Null> refreshList(String nam) async {
    await Future.delayed(Duration(seconds: 2));
    // getValidation();
    _rigList(nam);
  }

  Timer _clockTimer;

  @override
  void initState() {
    _rigList("");
    getValidation();
    super.initState();
    _clockTimer =
        Timer.periodic(Duration(seconds: 6), (Timer t) => _rigList(""));
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  void onEnd() {
    print('onEnd');
  }

  String formatDate(DateTime date) =>
      new DateFormat("dd-MM-yyyy.hh:mm a").format(date);

  int endT(DateTime due) {
    int tm;
    tm = due.millisecondsSinceEpoch;
    return tm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rig Alerts',
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
          margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
          height: double.infinity,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: ListTile(
                  leading:
                      Icon(Icons.sticky_note_2, size: 50.0, color: Colors.blue),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Recieved  ', style: TextStyle(fontSize: 22)),
                        TextSpan(
                            text: 'Rig Alerts', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 1, color: Colors.blue)),
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  onChanged: (value) {
                    _rigList(controller.text);
                  },
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  controller: controller,
                  decoration: new InputDecoration(
                    suffixIcon: controller.text.isNotEmpty
                        ? new IconButton(
                            icon: new Icon(Icons.cancel),
                            onPressed: () {
                              controller.clear();
                              _rigList(controller.text);
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
                    filled: true,
                    // fillColor: Colors.white24,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                        ? Center(child: Text("No Rig Alerts found"))
                        : ListView.builder(
                            itemCount: listFacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialogFunc(
                                      context,
                                      listFacts[index]["Name"],
                                      listFacts[index]["Position"],
                                      listFacts[index]["Date"],
                                      listFacts[index]["Created_Date"],
                                      listFacts[index]["Description"],
                                      listFacts[index]["rigName"] ?? "",
                                      listFacts[index]["profile_pic"] ?? "",
                                      listFacts[index]["id"] ?? "",
                                      posid);
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(
                                            child: ClipOval(
                                                child: Image.network(
                                                    getpath(listFacts[index]
                                                        ["profile_pic"]),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.fill)),
                                          ),
                                          title: Text(
                                            listFacts[index]["Name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.8,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            '(${listFacts[index]["Position"]})' +
                                                '\nRig name: ${listFacts[index]["rigName"]}',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                            ),
                                          ),
                                          trailing: Container(
                                            margin: EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                CountdownTimer(
                                                  endTime:
                                                      //  endT(index),
                                                      endT(DateTime.parse(
                                                          listFacts[index]
                                                              ["Date"])),
                                                  widgetBuilder: (_,
                                                      CurrentRemainingTime
                                                          time) {
                                                    if (time == null) {
                                                      return Text(
                                                        'Rig Alert Expired',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black54,
                                                        ),
                                                      );
                                                    }
                                                    return Text(
                                                      time.days == null
                                                          ? '${time.hours ?? 00}:${time.min ?? 00}:${time.sec}'
                                                          : '${time.hours + (time.days * 24)}:${time.min}:${time.sec}',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  },
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
                                                          title:
                                                              Text("Delete?"),
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
                                                                  deleterig(
                                                                      listFacts[
                                                                              index]
                                                                          [
                                                                          "id"]);
                                                                  _rigList("");
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
                                        ),
                                      ],
                                    ),
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
      floatingActionButton: jobError == true || mapResponse == null
          ? Center()
          : posid == '4'
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RigAlert2(
                                userId: sid,
                              )),
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

showDialogFunc(context, person, position, date, creteDate, content, rigName,
    path, id, posid) {
  int endT(DateTime due) {
    int tm;
    tm = due.millisecondsSinceEpoch;
    return tm;
  }

  bool st = true;

  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = 'https://picsum.photos/250?image=9';

      return pathf;
    } else {
      pathf = 'http://isow.acutrotech.com/assets/profilepic/' + path;
      return pathf;
    }
  }

  Future stopStatus(String rigId, String date) async {
    var data = {
      'id': rigId,
      'date': date,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Rigalert/dateupdate',
        body: (data));
    if (response.statusCode == 200) {
      // Toast.show("Status changed Successfully", context,
      //     duration: Toast.LENGTH_SHORT,
      //     gravity: Toast.BOTTOM,
      //     textColor: Colors.green[600],
      //     backgroundColor: Colors.white);

    } else {
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  String formatDate(DateTime date) =>
      new DateFormat("dd-MM-yyyy.hh:mm a").format(date);

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
                ListTile(
                  leading: CircleAvatar(
                    child: ClipOval(
                        child: Image.network(getpath(path),
                            width: 80, height: 80, fit: BoxFit.fill)),
                  ),
                  title: Text(
                    person,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, height: 1.8, fontSize: 16),
                  ),
                  subtitle: Text(
                    '($position)',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  trailing: Container(
                    child: CountdownTimer(
                      endTime:
                          //  endT(index),
                          endT(DateTime.parse(
                        date,
                      )),
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return Text(
                            'Rig Alert Expired',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          );
                        }
                        return Text(
                          time.days == null
                              ? '${time.hours ?? 00}:${time.min ?? 00}:${time.sec}'
                              : '${time.hours + (time.days * 24)}:${time.min}:${time.sec}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Rig Name        :  ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              rigName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Created Date  :  ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              creteDate,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CountdownTimer(
                              endTime:
                                  //  endT(index),
                                  endT(DateTime.parse(
                                date,
                              )),
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  return Text(
                                    'Expired on      :  ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  );
                                }
                                return Text(
                                  'Expire on         :  ',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            Text(
                              formatDate(DateTime.parse(date)),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    //  padding: EdgeInsets.all(8),
                    scrollDirection: Axis.vertical, //.horizontal
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 280,
                          child: new Text(
                              '${content[0].toUpperCase()}${content.substring(1)}',
                              // requirment,
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontSize: 14,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    posid == '4'
                        ? new SizedBox(
                            width: 130.0,
                            height: 45.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              color: Colors.red,
                              onPressed: () {
                                stopStatus(
                                    id,
                                    DateFormat('HH:mm:ss')
                                        .format(DateTime.now())
                                        .toString());
                                Timer(Duration(seconds: 1),
                                    () => Navigator.pop(context));
                              },
                              height: 30,
                              child: Text(
                                'STOP',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 5,
                          ),
                    SizedBox(
                      width: 5,
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
