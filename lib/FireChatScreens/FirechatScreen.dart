import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isow/Widgects/messageArea.dart';
import 'package:isow/Widgects/messageAreaService.dart';

class FireChatDetailScreen extends StatefulWidget {
  final String name;
  final String path;
  final String fromid;
  final String toid;
  final String chatId;
  final int navFrom;
  FireChatDetailScreen(
      {Key key,
      @required this.name,
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
  }

  createCollection(String docId, String chatId) {
    CollectionReference add = FirebaseFirestore.instance
        .collection('isowChat')
        .doc(docId)
        .collection(chatId);
    add.add({
      'createdAt': DateTime.now().toString(),
      'fromId': widget.toid,
      'message': "",
      'toId': widget.fromid
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
      createCollection(firedocumentId, widget.chatId);
    });

    print(firedocumentId);
    return firedocumentId;
  }

  Timer _clockTimer;
  @override
  void initState() {
    super.initState();
    getdocId(widget.chatId);
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

  // _textSt() {
  //   return TextStyle(
  //     fontSize: 15,
  //     color: Colors.white,
  //   );
  // }

  // _boxDec() {
  //   return BoxDecoration(
  //       borderRadius: BorderRadius.circular(30),
  //       border: Border.all(
  //         color: Colors.white70,
  //         width: 1.5,
  //       ));
  // }

//   final FocusScopeNode _node = FocusScopeNode();
//   _sendMessageArea() {
//     return Container(
//       //  padding: EdgeInsets.symmetric(horizontal: 8),
//       height: 180,
//       width: double.infinity,
//       color: Colors.blue,
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   //  alignment: Alignment.centerLeft,
//                   margin: EdgeInsets.symmetric(horizontal: 6),
//                   //  padding: EdgeInsets.symmetric(horizontal: 15),
//                   height: 45,
//                   decoration: _boxDec(),
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         width: 260,
//                         child: TextFormField(
//                           focusNode: _node,
//                           controller: messageController,
//                           decoration: new InputDecoration(
//                             suffixIcon: GestureDetector(
//                               onTap: () async {
//                                 CollectionReference add = FirebaseFirestore
//                                     .instance
//                                     .collection('isowChat')
//                                     .doc(firedocumentId)
//                                     .collection(widget.chatId);
//                                 add.add({
//                                   'createdAt': DateTime.now().toString(),
//                                   'fromId': widget.toid,
//                                   'message': messageController.text,
//                                   'toId': widget.id
//                                 });
//                                 messageController.clear();
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(
//                                       color: Colors.blue,
//                                       width: 3,
//                                     )),
//                                 child: Icon(
//                                   Icons.send,
//                                   color: Colors.blue,
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: 15, bottom: 11, top: 11, right: 15),
//                             hintText: 'Type your message..',

//                             // fillColor: Colors.white24,
//                             hintStyle: TextStyle(
//                                 color: Colors.black45,
//                                 fontSize: 12,
//                                 fontFamily: "WorkSansLight"),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.attachment,
//                         size: 22,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.camera_enhance,
//                         size: 22,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                     border: Border.all(width: 1.5, color: Colors.white70)),
//                 padding: EdgeInsets.all(11),
//                 margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
//                 child: Icon(
//                   Icons.mic,
//                   color: Colors.white,
//                   size: 22,
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.all(10),
//               width: double.infinity,
//               height: 150,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 40,
//                     child: Container(
//                       color: Colors.blue,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: double.infinity,
//                             decoration: _boxDec(),
//                             child: Text(
//                               "RIG",
//                               style: _textSt(),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: double.infinity,
//                             decoration: _boxDec(),
//                             child: Text(
//                               "LOC",
//                               style: _textSt(),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: double.infinity,
//                             decoration: _boxDec(),
//                             child: Text(
//                               "CAT ID",
//                               style: _textSt(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 20,
//                     child: Container(
//                       child: Icon(
//                         Icons.keyboard,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 40,
//                     child: Container(
//                       color: Colors.blue,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: double.infinity,
//                             decoration: _boxDec(),
//                             child: Text(
//                               "MR",
//                               style: _textSt(),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: double.infinity,
//                             decoration: _boxDec(),
//                             child: Text(
//                               "QTY",
//                               style: _textSt(),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 30,
//                             width: double.infinity,
//                             decoration: _boxDec(),
//                             child: Text(
//                               "B.K NO",
//                               style: _textSt(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

//   final FocusScopeNode _node = FocusScopeNode();
//   _sendMessageArea() {
//     DocumentSnapshot document;
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8),
//       height: 55,
//       margin: EdgeInsets.fromLTRB(7, 2, 7, 2),
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black45,
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(25))),
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.attachment_rounded),
//             iconSize: 25,
//             color: Colors.blue,
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               focusNode: _node,
//               controller: messageController,
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Send a message..',
//               ),
//               textCapitalization: TextCapitalization.sentences,
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             iconSize: 25,
//             color: Colors.blue,
//             onPressed: () async {
//               CollectionReference add = FirebaseFirestore.instance
//                   .collection('isowChat')
//                   .doc(firedocumentId)
//                   .collection(widget.chatId);
//               add.add({
//                 'createdAt': DateTime.now().toString(),
//                 'fromId': widget.toid,
//                 'message': messageController.text,
//                 'toId': widget.id
//               });
//               messageController.clear();
//             },
//           ),
//         ],
//       ),
//     );
//   }
}
