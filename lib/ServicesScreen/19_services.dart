import 'package:isow/Widgects/alertBox.dart';

import 'service_list.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  final String sid;
  Services({Key key, @required this.sid}) : super(key: key);
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Services",
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
                  builder: (context) => BuildLogoutDialogclose(widget.sid));
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Icon(
                    Icons.miscellaneous_services,
                    size: 80.0,
                    color: Color(0xff49A5FF),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 100.0,
                    margin: EdgeInsets.fromLTRB(5.0, 40.0, 10.0, 0.0),
                    child: Center(
                      child: TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        initialValue: '''Technical And Physical
Materialistic Issue''',
                        //maxLength: 100,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 25.0),
                          labelText: 'Services to solve problem',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff49A5FF)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceScreen(
                                  fromid: widget.sid,
                                  sid: '11',
                                )),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff49A5FF),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 70.0,
                          width: 70.0,
                          child: Icon(
                            Icons.desktop_windows_outlined,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.0),
                          height: 110.0,
                          width: 85.0,
                          alignment: Alignment.bottomCenter,
                          child: Text(''' IT Service
                        '''),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceScreen(
                                  fromid: widget.sid,
                                  sid: '12',
                                )),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff49A5FF),
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 70.0,
                          width: 70.0,
                          child: Icon(
                            Icons.emoji_people_outlined,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          height: 110.0,
                          width: 85.0,
                          alignment: Alignment.bottomCenter,
                          child: Text('''    Physical
Maintanance'''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: Color(0xff49A5FF),
            //           borderRadius: BorderRadius.circular(50.0),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black26,
            //               blurRadius: 6.0,
            //               offset: Offset(0, 2),
            //             ),
            //           ],
            //         ),
            //         // height: 100.0,
            //         margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            //         child: Center(
            //           child: TextFormField(
            //             onChanged: (value) {
            //               fetchData(controller.text);
            //             },
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),
            //             controller: controller,
            //             decoration: new InputDecoration(
            //               suffixIcon: controller.text.isNotEmpty
            //                   ? new IconButton(
            //                       icon: new Icon(
            //                         Icons.cancel,
            //                         color: Colors.white,
            //                       ),
            //                       onPressed: () {
            //                         controller.clear();
            //                         fetchData(controller.text);
            //                         // providerData.getContacts();
            //                         // onSearchTextChanged('');
            //                       },
            //                     )
            //                   : Icon(
            //                       Icons.search,
            //                       color: Colors.white,
            //                     ),

            //               border: InputBorder.none,
            //               focusedBorder: InputBorder.none,
            //               enabledBorder: InputBorder.none,
            //               errorBorder: InputBorder.none,
            //               disabledBorder: InputBorder.none,
            //               contentPadding: EdgeInsets.only(
            //                   left: 15, bottom: 11, top: 11, right: 15),
            //               hintText: 'Search',

            //               // fillColor: Colors.white24,
            //               hintStyle: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
