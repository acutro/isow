import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendChatArea extends StatelessWidget {
  final String docId;
  final String collectionId;
  final String fromId;
  final String toId;

  SendChatArea(this.docId, this.collectionId, this.fromId, this.toId);
  TextEditingController messageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final FocusScopeNode _node = FocusScopeNode();

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
                  .doc(docId)
                  .collection(collectionId);
              add.add({
                'createdAt': DateTime.now().toString(),
                'fromId': fromId,
                'message': messageController.text,
                'toId': toId
              });
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
