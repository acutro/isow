import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';

//import 'package:flutter_downloader/flutter_downloader.dart';

class ChatDetailScreen extends StatefulWidget {
  // final dynamic usename, isonline, senderId;
  // ChatDetailScreen({Key key, this.usename, this.isonline, this.senderId})
  //     : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  String formatDate(DateTime date) => new DateFormat(" hh:mm a").format(date);
  var currentdate = DateTime.now();
  TextEditingController sendDateController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  TextEditingController sendtoController = new TextEditingController();
  TextEditingController msgfromController = new TextEditingController();
  TextEditingController fileController = new TextEditingController();
  TextEditingController filepathController = new TextEditingController();

  File imageURI;
  TextEditingController msgController = new TextEditingController();

  List<dynamic> data;
  var count = 0;
  bool loading = true;
  bool error = false;
  int progress = 0;

  //ReceivePort _receivePort = ReceivePort();

  Widget checkTextOrImage(
    String pathfile,
    String subject,
  ) {
    // if (isFile == true) {
    //   downlimage(pathfile);
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.network(
          pathfile,
          width: 300,
          height: 200,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  ismee(int me) {
    bool mee;
    if (me == 20) {
      mee = true;
      return mee;
    } else {
      mee = false;
      return mee;
    }
  }

  @override
  void initState() {
    super.initState();

    //  getChatdb();
  }

  //test

  _chatBubble(String msg, String senddate, bool isMe, bool isSameUser,
      String pathfile, File imageURI) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                child: (pathfile != "")
                    ? Image.network(pathfile,
                        width: 300, height: 200, fit: BoxFit.cover)
                    : Text(
                        msg.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      formatDate(
                        DateTime.parse(senddate),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(),
                        //radius: 15,
                        // backgroundImage: AssetImage(message.sender.imageUrl),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Container(
                child: (pathfile != "")
                    ? Image.network(pathfile,
                        width: 300, height: 200, fit: BoxFit.cover)
                    : Text(
                        msg.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(),
                        //radius: 15,
                        //backgroundImage: AssetImage(message.sender.imageUrl),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatDate(
                        DateTime.parse(senddate),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.attachment_rounded),
            iconSize: 25,
            color: Colors.blue,
            onPressed: () => getImageFromGallery(),
          ),
          Expanded(
            child: TextField(
              controller: msgController,
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageURI = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blue,
        //centerTitle: true,
        title: Row(
          children: <Widget>[
            Text('User',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            true
                ? Container(
                    margin: const EdgeInsets.only(left: 14),
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  )
                : Container(),
          ],
        ),

        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: false,
                padding: EdgeInsets.all(20),
                //itemCount: count,
                itemCount: 10,

                //itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  // final Message message = messages[index];

                  //final ChatModel message = data[index];
                  final String msg = "hihji";
                  final String senddate = "767687688";
                  final String pathfile = "";
                  // final bool isFile = message.isfile;
                  final bool isSameUser = false;
                  //final String pathfile = message.filepath;
                  //final bool isMe =true;

                  final bool isMe = ismee(int.parse("1"));
                  //   final bool isSameUser =isSame(message.messageto);

                  // final bool isMe = message.messagefrom == currentUser.id;
                  // final bool isSameUser = prevUserId == message.sender.id;
                  // prevUserId = message.sender.id;

                  // return funtest(imageURI, message, isMe,
                  //     isSameUser, isFile, pathfile);

                  return _chatBubble(
                      msg, senddate, isMe, isSameUser, pathfile, imageURI);
                },
              ),
            ),
            _sendMessageArea(),
          ],
        ),
      ),
    );
  }
}
