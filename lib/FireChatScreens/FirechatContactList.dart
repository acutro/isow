import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:isow/Widgects/alertBox.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'FirechatScreen.dart';

class ChatAllContact extends StatefulWidget {
  final String sid;
  ChatAllContact({Key key, @required this.sid}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<ChatAllContact> {
  TextEditingController controller = new TextEditingController();
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Map catResponse;
  bool jobError = false;
  List<String> catogoryList = [];
  List<dynamic> catList;
  Future fetchCat() async {
    http.Response response;
    response = await http.get(FirebaseApi.chatListApi);
    if (response.statusCode == 200) {
      setState(() {
        catResponse = jsonDecode(response.body);
        catList = catResponse['data'];

        print("{$catList}");
      });
    }
  }

//   checkChat(List chatListt, String chatId) {
//     for (int i = 0; i < chatListt.length; i++) {
//       if(chatListt[i]['chatId']==chatId){
// return 0;
//       }
//     }
//   }

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

  Future fetchData(String namee, String uid) async {
    var data = {'name': namee, 'id': uid};
    http.Response response;
    response = await http.post(ApiUtils.contactApi, body: (data));
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
    fetchData(namee, widget.sid);
  }

  _textMe(String number) async {
    String uri = 'sms:' + number;
    await launch(uri);
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
    fetchData("", widget.sid);
    fetchCat();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select Contact",
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
      body: RefreshIndicator(
        onRefresh: () async {
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
                          fetchData(controller.text, widget.sid);
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
                                    fetchData(controller.text, widget.sid);
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
                                        Navigator.pop(context);
                                        // checkChat(
                                        //   catList,
                                        //   getChatid(
                                        //     widget.sid,
                                        //     listFacts[index]['id'],
                                        //   ),
                                        // );

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
                                                fromid: widget.sid,
                                                toid: listFacts[index]['id'],
                                                chatId: getChatid(
                                                  widget.sid,
                                                  listFacts[index]['id'],
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
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    title: Text(listFacts[index]
                                                        ["name"]),
                                                    subtitle: Text(
                                                      '${listFacts[index]["work"][0].toUpperCase()}${listFacts[index]["work"].substring(1)}',
                                                    ),
                                                  ),
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
    );
  }
}
