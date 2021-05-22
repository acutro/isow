import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'contact_details.dart';
import 'dart:convert';

class Contact extends StatefulWidget {
  // final String email;
  // Contact({Key key, @required this.email}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<Contact> {
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Future fetchData() async {
    http.Response response;
    response =
        await http.get('http://isow.acutrotech.com/index.php/api/Users/list');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        print("{$listFacts}");
      });
    }
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
    fetchData();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: listFacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final Message chat = chats[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactDetail(
                                    email: listFacts[index]["email"],
                                    mob: listFacts[index]["mob_num"],
                                    name: listFacts[index]["name"],
                                    id: listFacts[index]["id"].toString(),
                                    work: listFacts[index]["work"],
                                    ppath: listFacts[index]["profile_pic"],
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
                              width: MediaQuery.of(context).size.width * 0.90,
                              padding: EdgeInsets.all(3),
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
                                    title: Text(listFacts[index]["name"]),
                                    subtitle: Text(
                                      listFacts[index]["work"],
                                    ),
                                    trailing: Text(
                                      listFacts[index]["id"].toString() + "min",
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
    );
  }
}
