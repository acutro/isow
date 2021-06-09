import 'package:flutter_countdown_timer/countdown.dart';
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

      Toast.show("Something went Wrong", context,
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

  @override
  void initState() {
    _rigList("");
    getValidation();
    super.initState();
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
                child: ListTile(
                  leading: Icon(
                    Icons.sticky_note_2,
                    size: 70.0,
                    color: Color(0xff4fc4f2),
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Recieved  ', style: TextStyle(fontSize: 26)),
                        TextSpan(text: 'Rig Alerts'),
                      ],
                    ),
                  ),
                ),
                // child: Row(
                //   children: <Widget>[
                //     Container(
                //       //  margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                //       child: Icon(
                //         Icons.sticky_note_2,
                //         size: 70.0,
                //         color: Color(0xff4fc4f2),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         margin: EdgeInsets.fromLTRB(0.0, 40.0, 10.0, 0.0),
                //         child: Center(
                //             child: Text.rich(
                //           TextSpan(
                //             children: [
                //               TextSpan(
                //                   text: 'Recieved  ',
                //                   style: TextStyle(fontSize: 26)),
                //               TextSpan(text: 'Rig Alerts'),
                //             ],
                //           ),
                //         )),
                //       ),
                //     ),
                //   ],
                // ),
              ),
              Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),

                // width: MediaQuery.of(context).size.width*40,
                child: ListTile(
                  // leading: new Icon(Icons.search),
                  title: TextFormField(
                    controller: controller,
                    decoration: new InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
                      // fillColor: Colors.blue,
                      // filled: true
                    ),
                    onChanged: (value) {
                      _rigList(controller.text);
                    },
                  ),
                  trailing: controller.text.isNotEmpty
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
                    : listFacts.length == 0
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
                                                  color: Color(0xff4fc4f2),
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
                                                  listFacts[index]["Name"],
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
                                              color: Color(0xff4fc4f2),
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              child: Center(
                                                child: Text(
                                                  listFacts[index]["Position"],
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
                                                color: Color(0xff4fc4f2),
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              alignment: Alignment.topLeft,
                                              //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                                              child: Center(
                                                child: Text(
                                                  listFacts[index]
                                                          ["Created_Date"]
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
                                                  padding: EdgeInsets.all(10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Rig Name: ${listFacts[index]["rigName"][0].toUpperCase()}${listFacts[index]["rigName"].substring(1)}\nExpired on: ' +
                                                        formatDate(
                                                          DateTime.parse(
                                                              listFacts[index]
                                                                  ["Date"]),
                                                        ),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 100,
                                                  margin: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    '${listFacts[index]["Description"][0].toUpperCase()}${listFacts[index]["Description"].substring(1)}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        height: 1.5),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  child: CountdownTimer(
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
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        );
                                                      }
                                                      return Text(
                                                        time.days == null
                                                            ? 'Count Down:  ${time.hours ?? 00}:${time.min ?? 00}:${time.sec}'
                                                            : 'Count Down:  ${time.hours + (time.days * 24)}:${time.min}:${time.sec}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      );
                                                    },
                                                  ),
                                                  //  Text(
                                                  //   countTime,
                                                  //   // listFacts[index]
                                                  //   //     ["Alerted Rig List"],
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //       fontSize: 14,
                                                  //       fontWeight:
                                                  //           FontWeight.bold,
                                                  //       height: 1.5),
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

showDialogFunc(context, person, position, date, creteDate, content, rigName) {
  int endT(DateTime due) {
    int tm;
    tm = due.millisecondsSinceEpoch;
    return tm;
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
                Container(
                  child: Container(
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
                            '${rigName[0].toUpperCase()}${rigName.substring(1)}',
                            // title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, height: 1.5),
                          ),
                          subtitle: Text(
                            '${person[0].toUpperCase()}${person.substring(1)}\n${position[0].toUpperCase()}${position.substring(1)} ',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                          trailing: Text(
                            creteDate,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              '            Expired on: ' +
                                  formatDate(DateTime.parse(date)),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
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
                        CountdownTimer(
                          endTime: endT(
                            DateTime.parse(date),
                          ),
                          //  endT(index),

                          widgetBuilder: (_, CurrentRemainingTime time) {
                            if (time == null) {
                              return Text(
                                'Rig Alert Expired',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              );
                            }
                            return Text(
                              time.days == null
                                  ? 'Count Down:  ${time.hours ?? 00}:${time.min ?? 00}:${time.sec}'
                                  : 'Count Down:  ${time.hours + (time.days * 24)}:${time.min}:${time.sec}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            );
                          },
                        ),
                      ],
                    ),
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
