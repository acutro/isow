import 'package:flutter/material.dart';
import 'table.dart';
import 'page8rigalert.dart';

class Rigalert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          // onPressed: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => RigAlert2()),
          //   );
          // },
          child: const Icon(Icons.arrow_downward),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(4.0, 5.0, 10.0, 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 20.0,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20.0),
                      Text(
                        "April 10",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(width: 200.0),
                      Container(
                        child: Text(
                          "05:11PM",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
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
                    height: 510.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(width: 30.0),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            "COUNT DOWN TIME",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(15.0, 2.0, 0.0, 0.0),
                          child: Text(
                            "12    11    03",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // SizedBox(width: 30.0),
                        Container(
                          margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "HOURS    MINUTES    SECONDS",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //SizedBox(width: 30.0),
                        Row(
                          children: <Widget>[
                            // SizedBox(width: 20.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(15.0, 12.0, 0.0, 0.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "RIGNAME",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 140.0),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                "DATE",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            // SizedBox(width: 20.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Al Hudariyat",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 130.0),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                "10/04/2020",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                          child: Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                          child: Text(
                            '''Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod
tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis
nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
Duis autem vel eum iriure dolor in hendrerit in ''',
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                          child: Text(
                            "ALERTED RIG LIST",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        //SizedBox(height: 10.0),

                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Tables(),
                          ),
                        ),
                        //SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
