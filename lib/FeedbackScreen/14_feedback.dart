import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'feedbackList.dart';

class FeedbackCounter extends StatefulWidget {
  @override
  _FeedbackCounterState createState() => _FeedbackCounterState();
}

class _FeedbackCounterState extends State<FeedbackCounter> {
  Future upFeedback(
    String content,
  ) async {
    var data = {
      'content': content,
      'opinion': 'mm',
      'userId': '5',
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/Feedback/create',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Feedback Added Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
    } else {
      Toast.show("Failed try again", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  TextEditingController _feedbackController = new TextEditingController();
  // TextEditingController _opinionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text('Feedback Counter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: Icon(
                    Icons.message,
                    size: 90.0,
                    color: Color(0xff49A5FF),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 40.0, 10.0, 0.0),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Whats Employers\n',
                            ),
                            TextSpan(
                                text: 'Opinion and Issues?',
                                style: TextStyle(fontSize: 24)),
                          ],
                        ),
                      ),
                    ),

                    //  TextFormField(
                    //   cursorColor: Theme.of(context).cursorColor,
                    //   // initialValue: 'Opinion and Issue?',
                    //   maxLength: 20,
                    //   controller: _opinionController,
                    //   decoration: InputDecoration(
                    //     // icon: Icon(Icons.favorite),
                    //     labelText: '''What's Empoloyers''',
                    //     labelStyle: TextStyle(
                    //       color: Color(0xFF6200EE),
                    //     ),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Color(0xFF6200EE)),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 300.0,
                    //width: 300.0,
                    //color: Colors.redAccent,
                    // child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'COUNTER SECTION : 20',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: Divider(
                            color: Colors.black,
                            height: 30,
                            thickness: 1.0,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.all(10.0),
                              child: new TextField(
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                autofocus: false,
                                maxLines: null,
                                controller: _feedbackController,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 200.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(0xff49A5FF),
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Center(
                        child: Text(
                          'Submit Feedback',
                          style:
                              TextStyle(color: Colors.white.withOpacity(1.0)),
                        ),
                      ),
                      onTap: () {
                        if (_feedbackController.text == "") {
                          Toast.show("Please enter Feedback", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM,
                              textColor: Color(0xff49A5FF),
                              backgroundColor: Colors.white);
                        } else {
                          upFeedback(
                            _feedbackController.text,
                          );
                          _feedbackController.text = "";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedbackList()),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(100.0),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black12,
            //             blurRadius: 6.0,
            //             offset: Offset(0, 2),
            //           ),
            //         ],
            //       ),
            //       child: InkWell(
            //         child: Center(
            //           child: Icon(
            //             Icons.add_outlined,
            //             color: Colors.black54,
            //             size: 50.0,
            //           ),
            //         ),

            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}