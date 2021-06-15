import 'package:flutter/material.dart';
import 'package:isow/contacts/contact.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String path;

  ChatDetailScreen({Key key, @required this.name, this.path}) : super(key: key);
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
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
            child: ListView.builder(
              itemCount: 20,
              padding: EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int index) {
                final String msg = "hijhfdbhfbhgfjfhkjfhfkjhkjhgdfkjhhji";
                final String senddate = "767687688";
                final String pathfile = "";

                final bool isMe = index % 2 == 0;

                return _chatBubble(msg, senddate, isMe, pathfile);
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
        alignment: (isMe == true ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft:
                    isMe == true ? Radius.circular(0.0) : Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: isMe == true
                    ? Radius.circular(10.0)
                    : Radius.circular(0.0)),
            color: (isMe == true ? Colors.grey.shade200 : Colors.blue[600]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            msg,
            style: TextStyle(
              fontSize: 15,
              color: (isMe == true ? Colors.black87 : Colors.white),
            ),
          ),
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
                          decoration: new InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {},
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
