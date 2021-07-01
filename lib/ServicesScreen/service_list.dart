import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isow/ChatScreens/chatScreenMain.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ServiceScreen extends StatefulWidget {
  final String sid;
  final String fromid;
  ServiceScreen({Key key, @required this.sid, this.fromid}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<ServiceScreen> {
  TextEditingController controller = new TextEditingController();
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;

  bool jobError = false;
  Future fetchData(String namee) async {
    var data = {
      'roleId': widget.sid,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Services/singlelist',
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home: Scaffold(
        appBar: AppBar(
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
                            fetchData(controller.text);
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
                                      fetchData(controller.text);
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
                                    heightFactor: 10, child: Text("Not found"))
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
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ChatDetailScreen(
                                                                        name: listFacts[index]
                                                                            [
                                                                            "name"],
                                                                        path:
                                                                            getpath(
                                                                          listFacts[index]
                                                                              [
                                                                              "profile_pic"],
                                                                        ),
                                                                        id: listFacts[index]
                                                                            [
                                                                            'id'],
                                                                        toid: widget
                                                                            .fromid,
                                                                      ),
                                                                    ));
                                                              },
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
                ),
        ),
      ),
    );
  }
}