import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:isow/ApiUtils/apiUtils.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isow/Widgects/messageArea.dart';
import 'package:isow/Widgects/messageAreaService.dart';

class FireChatDetailScreen extends StatefulWidget {
  final String existFlag;
  final String name;
  final String path;
  final String fromid;
  final String toid;
  final String chatId;
  final int navFrom;
  FireChatDetailScreen(
      {Key key,
      @required this.existFlag,
      this.name,
      this.path,
      this.fromid,
      this.toid,
      this.chatId,
      this.navFrom})
      : super(key: key);
  @override
  _FireChatDetailScreenState createState() => _FireChatDetailScreenState();
}

class _FireChatDetailScreenState extends State<FireChatDetailScreen> {
  TextEditingController messageController = new TextEditingController();

  // void docId() async {
  //   var docRef = await FirebaseFirestore.instance
  //       .collection('isowChat')
  //       .where('chatId', isEqualTo: '134')
  //       .get();
  //   String docidd = docRef.docs[0].id;
  //   print(docidd);
  //   print(docRef);
  // }
  createDocument(String cId) async {
    CollectionReference add = FirebaseFirestore.instance.collection('isowChat');
    add.add({'chatId': cId});
    getdocId(widget.chatId);
  }

  createCollection(String docId, String chatId) {
    CollectionReference add = FirebaseFirestore.instance
        .collection('isowChat')
        .doc(docId)
        .collection(chatId);
    add.add({
      'createdAt': DateTime.now().toString(),
      'fromId': widget.fromid,
      'message': "",
      'toId': widget.toid
    });
  }

  String firedocumentId;
  Future<String> getdocId(String chatId) async {
    var docRef = await FirebaseFirestore.instance
        .collection('isowChat')
        .where('chatId', isEqualTo: chatId)
        .get();
    setState(() {
      docRef.docs.length != 0
          ? firedocumentId = docRef.docs[0].id
          : createDocument(chatId);
      // createCollection(firedocumentId, widget.chatId);
    });

    print(firedocumentId);
    return firedocumentId;
  }

  Future createChat(String fid, String tid, String cid) async {
    var data = {'fromId': fid, 'toId': tid, 'chatId': cid};
    http.Response response;
    response = await http.post(FirebaseApi.fireChatCreateApi, body: (data));
    if (response.statusCode == 200) {
      createCollection(firedocumentId, widget.chatId);
      print('Success');
    } else {
      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  checkUser(String flag) {
    if (flag == '1') {
      createChat(widget.fromid, widget.toid, widget.chatId);
    }
  }

  Timer _clockTimer;
  @override
  void initState() {
    super.initState();
    getdocId(widget.chatId);
    checkUser(widget.existFlag);
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    // _node.dispose();
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
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('isowChat')
                  .doc(firedocumentId)
                  .collection(widget.chatId)
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) return const Text("Loading..");
                return ListView.builder(
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    final String msg =
                        snapshots.data.docs[index]['message'].toString();
                    final String senddate =
                        snapshots.data.docs[index]['createdAt'].toString();
                    final String pathfile = "";
                    final String from =
                        snapshots.data.docs[index]['fromId'].toString();
                    final String to =
                        snapshots.data.docs[index]['toId'].toString();

                    final bool isMe =
                        snapshots.data.docs[index]['fromId'] == widget.fromid
                            ? true
                            : false;
                    //_buildListitem(context, snapshots.data.docs[index]),

                    return _chatBubble(msg, senddate, isMe, pathfile);
                  },
                );
              },
            ),
          ),
          widget.navFrom == 0
              ? SendChatAreaService(
                  firedocumentId, widget.chatId, widget.toid, widget.fromid)
              : SendChatArea(
                  firedocumentId, widget.chatId, widget.toid, widget.fromid),
        ],
      )),
    );
  }

  _chatBubble(String msg, String senddate, bool isMe, String pathfile) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: msg == ""
          ? SizedBox()
          : Align(
              alignment:
                  (isMe == true ? Alignment.topRight : Alignment.topLeft),
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
                      color: (isMe == true
                          ? Colors.blue[600]
                          : Colors.grey.shade200),
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
                    senddate.toString(),
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
}
