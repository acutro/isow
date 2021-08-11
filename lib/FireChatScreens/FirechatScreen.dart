import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireChatDetailScreen extends StatefulWidget {
  final String name;
  final String path;
  final String id;
  final String toid;
  FireChatDetailScreen(
      {Key key, @required this.name, this.path, this.id, this.toid})
      : super(key: key);
  @override
  _FireChatDetailScreenState createState() => _FireChatDetailScreenState();
}

class _FireChatDetailScreenState extends State<FireChatDetailScreen> {
  TextEditingController messageController = new TextEditingController();

  void docId() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('isowChat')
        .where('chatId', isEqualTo: '134')
        .get();

    List idl = snapshot.docs;
    String iddd = idl[0]['id'].toString();
    print(iddd);
  }

  Timer _clockTimer;
  @override
  void initState() {
    super.initState();
    docId();
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _node.dispose();
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
                  .doc('TBzR4cpSmWSBefc8VNIW')
                  .collection('134')
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
                        snapshots.data.docs[index]['fromId'] == widget.toid
                            ? true
                            : false;
                    //_buildListitem(context, snapshots.data.docs[index]),

                    return _chatBubble(msg, senddate, isMe, pathfile);
                  },
                );
              },
            ),
          ),
          _sendMessageArea(),
        ],
      )),
    );
  }

  _chatBubble(String msg, String senddate, bool isMe, String pathfile) {
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
    DocumentSnapshot document;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 55,
      margin: EdgeInsets.fromLTRB(7, 2, 7, 2),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.attachment_rounded),
            iconSize: 25,
            color: Colors.blue,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              focusNode: _node,
              controller: messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.blue,
            onPressed: () async {
              CollectionReference add = FirebaseFirestore.instance
                  .collection('isowChat')
                  .doc('TBzR4cpSmWSBefc8VNIW')
                  .collection('134');
              add.add({
                'createdAt': DateTime.now().toString(),
                'fromId': widget.toid,
                'message': messageController.text,
                'toId': widget.id
              });
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
