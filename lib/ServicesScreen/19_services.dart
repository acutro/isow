import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List listResponse;
  TextEditingController controller = new TextEditingController();
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future fetchData(String namee) async {
    var data = {
      'name': namee,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SearchList/searchUsers',
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

      Toast.show("No Contacts Found", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future<Null> refreshList(String namee) async {
    await Future.delayed(Duration(seconds: 2));
    fetchData(namee);
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

  @override
  void initState() {
    fetchData("");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Services'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Icon(
                    Icons.miscellaneous_services,
                    size: 60.0,
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
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
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
                Stack(
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
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff49A5FF),
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    // height: 100.0,
                    margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                    child: Center(
                      child: TextFormField(
                        onChanged: (value) {
                          fetchData(controller.text);
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: controller,
                        decoration: new InputDecoration(
                          suffixIcon: controller.text.isNotEmpty
                              ? new IconButton(
                                  icon: new Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    controller.clear();
                                    fetchData(controller.text);
                                    // providerData.getContacts();
                                    // onSearchTextChanged('');
                                  },
                                )
                              : Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),

                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Search',

                          // fillColor: Colors.white24,
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: jobError == true || mapResponse == null
                      ? Center(
                          child: SpinKitChasingDots(
                            color: Colors.blue,
                            size: 100,
                          ),
                        )
                      : Container(
                          child: SingleChildScrollView(
                            child: listFacts == null
                                ? Center(
                                    heightFactor: 10,
                                    child: Text("No Service Contact found"))
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listFacts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // final Message chat = chats[index];
                                      return GestureDetector(
                                        onTap: () {},
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
                                                        child: ClipOval(
                                                            child: Image.network(
                                                                getpath(listFacts[
                                                                        index][
                                                                    "profile_pic"]),
                                                                width: 80,
                                                                height: 80,
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                      title: Text(
                                                          listFacts[index]
                                                              ["name"]),
                                                      subtitle: Text(
                                                        '${listFacts[index]["work"][0].toUpperCase()}${listFacts[index]["work"].substring(1)}',
                                                      ),
                                                      trailing: Container(
                                                        width: 75,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Icon(
                                                                Icons
                                                                    .chat_sharp,
                                                                size: 25,
                                                                color: Colors
                                                                    .blue[400],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                launch(
                                                                  "tel:" +
                                                                      listFacts[
                                                                              index]
                                                                          [
                                                                          "mob_num"],
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons.call,
                                                                size: 25,
                                                                color: Colors
                                                                    .green[400],
                                                              ),
                                                            ),
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
                                      );
                                    },
                                  ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
