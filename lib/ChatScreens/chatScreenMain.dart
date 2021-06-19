import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:isow/contacts/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String path;
  final String id;
  final String toid;

  ChatDetailScreen(
      {Key key, @required this.name, this.path, this.id, this.toid})
      : super(key: key);
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController messageController = new TextEditingController();

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future chatUp(
    String fromid,
    String toid,
    String message,
  ) async {
    var data = {
      'fromId': fromid,
      'toId': toid,
      'message': message,
      'send_by': fromid
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Chat/create',
        body: (data));
    if (response.statusCode == 200) {
      // Toast.show("Executed Successfully", context,
      //     duration: Toast.LENGTH_SHORT,
      //     gravity: Toast.BOTTOM,
      //     textColor: Colors.green[600],
      //     backgroundColor: Colors.white);
      Timer(
        Duration(milliseconds: 10),
        () => fetchChat(widget.toid, widget.id),
      );
    } else {
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future fetchChat(String fromid, String toid) async {
    var data = {'fromId': fromid, 'toId': toid};
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Chat/singleList',
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

  Timer _clockTimer;
  @override
  void initState() {
    super.initState();
    fetchChat(widget.toid, widget.id);
    _clockTimer = Timer.periodic(
        Duration(seconds: 15), (Timer t) => fetchChat(widget.toid, widget.id));
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
        brightness: Brightness.dark,
        backgroundColor: Colors.blue,
        //centerTitle: true,
        title: Row(
          children: <Widget>[
            CircleAvatar(child: ClipOval(child: Image.network(widget.path))),
            SizedBox(
              width: 10,
            ),
            Text(widget.name,
                style: TextStyle(
                  fontSize: 16,
                )),
            Container(
              margin: const EdgeInsets.all(10),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            )
          ],
        ),

        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          SizedBox(
            width: 10,
          ),
          Icon(Icons.video_call),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.call),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: jobError == true || mapResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : SafeArea(
              child: Column(
              children: [
                Expanded(
                  child: listFacts.length == 0
                      ? Center(child: Text("No Messages found"))
                      : ListView.builder(
                          itemCount: listFacts.length,
                          padding: EdgeInsets.all(20),
                          itemBuilder: (BuildContext context, int index) {
                            final String msg = listFacts[index]['message'];
                            final String senddate = listFacts[index]['date'];
                            final String pathfile = "";

                            final bool isMe =
                                listFacts[index]['send_by'] == widget.toid;

                            return _chatBubble(
                                msg, senddate, isMe, pathfile, senddate);
                          },
                        ),
                ),
                _sendMessageArea(),
              ],
            )),
    );
  }

  _chatBubble(
      String msg, String senddate, bool isMe, String pathfile, String date) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (isMe == true ? Alignment.topRight : Alignment.topLeft),
        child: Column(
          crossAxisAlignment: (isMe == true
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start),
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: isMe == true
                        ? Radius.circular(10.0)
                        : Radius.circular(0.0),
                    topRight: Radius.circular(10.0),
                    bottomRight: isMe == true
                        ? Radius.circular(0.0)
                        : Radius.circular(10.0)),
                color: (isMe == true ? Colors.blue[600] : Colors.grey.shade200),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 13,
                  color: (isMe == true ? Colors.white : Colors.black87),
                ),
              ),
            ),
            Text(
              date.substring(10),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 10,
                color: (Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _textSt() {
    return TextStyle(
      fontSize: 15,
      color: Colors.white,
    );
  }

  _boxDec() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white70,
          width: 1.5,
        ));
  }

  final FocusScopeNode _node = FocusScopeNode();
  _sendMessageArea() {
    return Container(
      //  padding: EdgeInsets.symmetric(horizontal: 8),
      height: 180,
      width: double.infinity,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  //  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  //  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 45,
                  decoration: _boxDec(),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: 260,
                        child: TextFormField(
                          focusNode: _node,
                          controller: messageController,
                          decoration: new InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                chatUp(widget.toid, widget.id,
                                    messageController.text);
                                messageController.clear();
                                _node.unfocus();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 3,
                                    )),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                  size: 22,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: 'Type your message..',

                            // fillColor: Colors.white24,
                            hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                                fontFamily: "WorkSansLight"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.attachment,
                        size: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.camera_enhance,
                        size: 22,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(width: 1.5, color: Colors.white70)),
                padding: EdgeInsets.all(11),
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    flex: 40,
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: double.infinity,
                            decoration: _boxDec(),
                            child: Text(
                              "RIG",
                              style: _textSt(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: double.infinity,
                            decoration: _boxDec(),
                            child: Text(
                              "LOC",
                              style: _textSt(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: double.infinity,
                            decoration: _boxDec(),
                            child: Text(
                              "CAT ID",
                              style: _textSt(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Container(
                      child: Icon(
                        Icons.keyboard,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: double.infinity,
                            decoration: _boxDec(),
                            child: Text(
                              "MR",
                              style: _textSt(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: double.infinity,
                            decoration: _boxDec(),
                            child: Text(
                              "QTY",
                              style: _textSt(),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: double.infinity,
                            decoration: _boxDec(),
                            child: Text(
                              "B.K NO",
                              style: _textSt(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
