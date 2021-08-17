import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'FirechatContactList.dart';
import 'FirechatScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FireChatListScreen extends StatefulWidget {
  @override
  _FireChatListScreenState createState() => _FireChatListScreenState();
}

class _FireChatListScreenState extends State<FireChatListScreen> {
  TextEditingController controller = new TextEditingController();
  String sid;

  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');

    setState(() {
      sid = id;
      fetchData(id);
      error = false;
    });
  }

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;

  bool jobError = false;
  Future fetchData(String fromid) async {
    var data = {'userId': fromid};
    http.Response response;
    response = await http.post(FirebaseApi.fireChatListApi, body: (data));
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

  getChatid(String sFromId, String sToId) {
    int fromId = int.parse(sFromId);
    String chatId;
    int toId = int.parse(sToId);
    if (fromId < toId) {
      chatId = toId.toString() + fromId.toString();
      return chatId;
    } else {
      chatId = fromId.toString() + toId.toString();
      return chatId;
    }
  }

  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = UserAuthApi.profileImageApi + 'default.png';

      return pathf;
    } else {
      pathf = UserAuthApi.profileImageApi + path;
      return pathf;
    }
  }

  @override
  void initState() {
    // fetchData("");

    super.initState();
    getValidation();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chat",
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refreshList(sid);
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
                          fetchData(sid);
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
                                    fetchData(sid);
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
                                  heightFactor: 10,
                                  child: Text("No Contact found"))
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listFacts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // final Message chat = chats[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FireChatDetailScreen(
                                                name: listFacts[index]["name"],
                                                path: getpath(
                                                  listFacts[index]
                                                      ["profile_pic"],
                                                ),
                                                fromid: listFacts[index]
                                                    ['toId'],
                                                toid: sid,
                                                chatId: getChatid(
                                                  listFacts[index]['fromId'],
                                                  listFacts[index]['toId'],
                                                ),
                                                navFrom: 0,
                                              ),
                                            ));
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
                                                      trailing: Text(
                                                          listFacts[index]
                                                                  ["empId"]
                                                              .toString())),
                                                  Divider(),
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatAllContact(sid: sid)),
            );
          },
          child: Icon(Icons.message)),
    );
  }
}
