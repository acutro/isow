import 'package:flutter/material.dart';
import 'sizeadjust.dart';
import 'copy.dart';
import '9_RigAlertsendmsg.dart';

class RigAlert2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rig Alert',
            style: TextStyle(fontSize: 15),
          ),
        ),
        leading: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Material(
            shape: new CircleBorder(),
          ),
        ),
        actions: [
          Icon(Icons.headset_mic),
          Icon(Icons.logout),
          Icon(Icons.more_vert),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xfffcfafa),
          foregroundColor: Colors.black54,
          mini: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Rigalert()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 100.0,
            //width: double.infinity,
            child: Row(
              children: <Widget>[
                Container(
                  height: 110,
                  // width: 110,
                  margin: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 5.0),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/scn1.PNG',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 10),
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(1.0, 10.0, 0.0, 5.0),
                        child: Text(
                          "COUNT DOWN TIME",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(5.0, 0.1, 5.0, 5.0),
                            //padding: EdgeInsets.all(5),

                            child: Text(''),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                )),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(5.0, 0.1, 5.0, 5.0),
                            //padding: EdgeInsets.all(5),

                            child: Text(''),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                )),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(5.0, 0.1, 5.0, 5.0),
                            //padding: EdgeInsets.all(5),

                            child: Text(''),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                )),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.1, 0.0, 0.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "HOURS      MINUTES      SECONDS",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              // SizedBox(width: 20.0),
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: Text(
                  "RIGNAME",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 40),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  "DATE",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'User Name',
                    // hintText: 'Enter Your Name',
                  ),
                ),
                width: SizeConfig.safeBlockHorizontal * 40,
                height: SizeConfig.safeBlockVertical * 5,
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
              //SizedBox( height:SizeConfig.safeBlockVertical * 5),
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'User Name',
                    // hintText: 'Enter Your Name',
                  ),
                ),
                width: SizeConfig.safeBlockHorizontal * 40,
                height: SizeConfig.safeBlockVertical * 5,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                alignment: Alignment.topLeft,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Description Field",
                    // hintText: 'Enter Your Name',
                  ),
                ),
                height: SizeConfig.safeBlockVertical * 10,
                width: SizeConfig.safeBlockHorizontal * 90,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                // alignment: Alignment.topLeft,
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4fc4f2), Colors.blue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Alert",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
              Container(
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                // alignment: Alignment.topLeft,
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Colors.blue,
                        )),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "View Rig Alert List",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
            child: Text(
              "ALERTED RIG LIST",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Tables2(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
            // alignment: Alignment.topLeft,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4fc4f2), Colors.blue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Send",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
