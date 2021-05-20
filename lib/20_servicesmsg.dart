import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Servicemessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text('Service Message'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 30.0, 5.0, 10.0),
                child: Text(
                  'REFERENCE NUMBER:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 10.0),
                  child: Text(
                    '23569287',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 10.0),
                  child: Text(
                    'Priority:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                child: Text(
                  'High',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                // height: 300.0,
                child: Text(
                    '''Lorem ipsum dolor sit amet, consectetuer adipiscing elit, seddiam nonummy nibh euismod tincidunt ut laoreet doloremagna aliquam erat volutpat. Ut wisi enim ad minim veniam,quis nostrud exerci tation ullamcorper suscipit lobortis nisl utaliquip ex ea commodo consequat. Duis autem vel eum iriuredolor in hendrerit in vulputate velit esse molestie consequat,vel illum dolore eu feugiat nulla facilisis at vero eros etaccumsan et iusto odio dignissim qui blandit praesentluptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, cons ectetuer adipiscing elit, seddiam nonummy nibh euismod tincidunt ut laoreet doloremagna aliquam erat volutpat. Ut wisi enim ad minim veniaquis nostrud exerci tation ullamcorper suscipit lobortis nisl utaliquip ex ea commodo consequat.'''),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                          decoration: BoxDecoration(
                            color: Color(0xff49A5FF),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(15.0, 25.0, 20.0, 0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 40.0,
                                      margin: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 0.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10.0, 0.0, 50.0, 15.0),
                                          border: InputBorder.none,
                                          hintText: 'Type your message',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15.0,
                                      right: 0.1,
                                      child: Container(
                                        height: 30.0,
                                        //margin: EdgeInsets.fromLTRB(0.0, 10.0, 150.0, 0.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.send,
                                            color: Color(0xff49A5FF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30.0,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30.0,
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.attach_file_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    margin: EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                      color: Color(0xff49A5FF),
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mic_none_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
