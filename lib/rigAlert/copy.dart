import 'package:flutter/material.dart';

class Tables2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Tables2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(children: <Widget>[
      Container(
        // height: 70,
        // height: SizeConfig.safeBlockVertical * 15,
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Table(
          border: TableBorder.all(color: Colors.white),
          columnWidths: {
            0: FractionColumnWidth(.14),
            1: FractionColumnWidth(.14),
            2: FractionColumnWidth(.14),
            3: FractionColumnWidth(.14),
            4: FractionColumnWidth(.14),
            5: FractionColumnWidth(.15),
            6: FractionColumnWidth(.15),
          },
          children: [
            TableRow(
              children: [
                Column(
                  children: [
                    //Icon(Icons.account_box, size: iconSize,),

                    //alignment: Alignment.center,
                    Container(
                      child: Text(
                        'Date',
                        style: new TextStyle(
                          fontSize: 7.1,
                          // margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          color: Colors.white,
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 1.0),
                      //alignment: Alignment.center,
                      // color: Colors.blue,
                    ),
                  ],
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                ),
                Column(children: [
                  Container(
                    child: Text(
                      'ID',
                      style: new TextStyle(
                        fontSize: 7.1,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 1.0),
                  )
                ]),
                Column(children: [
                  Container(
                    child: Text(
                      'Name',
                      style: new TextStyle(
                        fontSize: 7.1,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 1.0),
                  )
                ]),
                Column(children: [
                  Container(
                    child: Text(
                      'Position',
                      style: new TextStyle(
                        fontSize: 7.1,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 1.0),
                  )
                ]),
                Column(children: [
                  Container(
                    child: Text(
                      'Alerted Rig List',
                      style: new TextStyle(
                        fontSize: 8.1,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 1.0),
                  )
                ]),
                Column(children: [
                  Container(
                    child: Text(
                      'Description',
                      style: new TextStyle(
                        fontSize: 7.1,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(1.0, 8.0, 0.0, 1.0),
                  )
                ]),
                Column(children: [
                  Container(
                    child: Text(
                      'CountDown',
                      style: new TextStyle(
                        fontSize: 7.1,
                        color: Colors.white,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 1.0),
                  ),
                ]),
              ],
              decoration: BoxDecoration(color: Color(0xFF30a0ff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
            TableRow(
              children: [
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
                Text(' '),
              ],
              decoration: BoxDecoration(color: Color(0xFFdeebff)),
            ),
          ],
        ),
      ),
    ]));
  }
}
