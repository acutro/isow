import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:isow/UserAuth/2_signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isow/Widgects/messageArea.dart';
import 'package:isow/Widgects/messageAreaService.dart';

class SendChatAreaService extends StatelessWidget {
  final String docId;
  final String collectionId;
  final String fromId;
  final String toId;

  SendChatAreaService(this.docId, this.collectionId, this.fromId, this.toId);

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

  TextEditingController messageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final FocusScopeNode _node = FocusScopeNode();

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
                              onTap: () async {
                                CollectionReference add = FirebaseFirestore
                                    .instance
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
