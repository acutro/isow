import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'contact_details.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Contact extends StatefulWidget {
  // final String email;
  // Contact({Key key, @required this.email}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<Contact> {
  TextEditingController controller = new TextEditingController();
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  // Future fetchData() async {
  //   http.Response response;
  //   response =
  //       await http.get('http://isow.acutrotech.com/index.php/api/Users/list');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       mapResponse = jsonDecode(response.body);
  //       listFacts = mapResponse['data'];
  //       print("{$listFacts}");
  //     });
  //   }
  // }

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

  // Future fetchData() async {
  //   http.Response response;
  //   response = await http
  //       .post('http://isow.acutrotech.com/index.php/api/SearchLists/search');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       mapResponse = jsonDecode(response.body);
  //       listFacts = mapResponse['data'];
  //       print("{$listFacts}");
  //     });
  //   }
  // }

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
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contacts",
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
          child: mapResponse == null
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
                        alignment: Alignment.center,
                        // padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(horizontal: 15),
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
                              fetchData(controller.text);
                            },
                          ),
                          trailing: controller.text.isNotEmpty
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
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listFacts.length,
                              itemBuilder: (BuildContext context, int index) {
                                // final Message chat = chats[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactDetail(
                                                email: listFacts[index]
                                                    ["email"],
                                                mob: listFacts[index]
                                                    ["mob_num"],
                                                name: listFacts[index]["name"],
                                                id: listFacts[index]["userId"]
                                                    .toString(),
                                                work: listFacts[index]["work"],
                                                ppath: listFacts[index]
                                                    ["profile_pic"],
                                              )),
                                    );
                                  },
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
                                                                  index]
                                                              ["profile_pic"]),
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.fill)),
                                                ),
                                                title: Text(
                                                    listFacts[index]["name"]),
                                                subtitle: Text(
                                                  '${listFacts[index]["work"][0].toUpperCase()}${listFacts[index]["work"].substring(1)}',
                                                ),
                                                trailing: Text(
                                                  "ID: " +
                                                      listFacts[index]["userId"]
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black54,
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
