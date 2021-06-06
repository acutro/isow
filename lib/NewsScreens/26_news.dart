import 'package:flutter/material.dart';
import 'newsListing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'activityList.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Future fetchData() async {
    http.Response response;
    response =
        await http.get('http://isow.acutrotech.com/index.php/api/News/list');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        print("{$listFacts}");
      });
    }
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text('News'),
        centerTitle: true,
      ),
      body: mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                        child: Icon(
                          Icons.new_releases_sharp,
                          size: 90.0,
                          color: Color(0xff49A5FF),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Color(0xff49A5FF),
                                height: 1.0,
                              ),
                              height: 55.0,
                              //color: Color(0xff49A5FF),
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                            ),
                            Container(
                                alignment: Alignment.bottomLeft,
                                height: 50.0,
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Company',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'News',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black54),
                                      ),
                                    )
                                  ],
                                )),

                            // Container(
                            //   color: Colors.blueGrey,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.blue[100],
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff0E4D92).withOpacity(0.5),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listFacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final Message chat = chats[index];
                        return GestureDetector(
                          onTap: () {
                            showDialogFunc(
                              context,
                              listFacts[index]["title"],
                              listFacts[index]["description"],
                            );
                          },
                          child: Row(
                            children: [
                              Card(
                                elevation: 5,
                                shadowColor: Color(0xff0E4D92),
                                color: Color(0xff0E4D92),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      color: Color(0xff49A5FF),
                                      child: Center(
                                          child: Text(
                                        listFacts[index]["title"].length > 40
                                            ? listFacts[index]["title"]
                                                    .substring(0, 25) +
                                                "..."
                                            : listFacts[index]["title"] + "..",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.3,
                                      color: Color(0xff0E4D92),
                                      child: Center(
                                          child: Text(
                                              listFacts[index]["description"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      color: Color(0xFF4fc4f2),
                      textColor: Colors.white,
                      child: Text('More News..'),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsListing(
                                    newsList: listFacts,
                                  )),
                        ),
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                        child: Icon(
                          Icons.lock_clock,
                          size: 90.0,
                          color: Color(0xff49A5FF),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Color(0xff49A5FF),
                                height: 1.0,
                              ),
                              height: 55.0,
                              //color: Color(0xff49A5FF),
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: 50.0,
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                              child: Text(
                                'Activities',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.black54),
                              ),
                            ),

                            // Container(
                            //   color: Colors.blueGrey,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ActivityListing()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 100.0,
                                    child: Text(
                                      'Team Building',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 80.0,
                                    child:
                                        Image.asset('assets/images/team.png'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ActivityListing()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 100.0,
                                    child: Text(
                                      'Sports',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 80.0,
                                    child:
                                        Image.asset('assets/images/sports.png'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ActivityListing()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 100.0,
                                    child: Text(
                                      'Tour',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 80.0,
                                    child:
                                        Image.asset('assets/images/tour.png'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      color: Color(0xFF4fc4f2),
                      textColor: Colors.white,
                      child: Text('More Activities..'),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivityListing()),
                        ),
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

showDialogFunc(context, date, description) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          type: MaterialType.card,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            height: 400,
            width: 350,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(3),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFF4fc4f2),
                                child: Text(
                                  'N',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              title: Text(
                                date,
                                // title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "Mumbai. 12 May 2020",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                              // trailing: InkWell(
                              //     onTap: () {
                              //       Navigator.pop(context);
                              //     },
                              //     child: Icon(
                              //       Icons.delete,
                              //       color: Colors.red[400],
                              //     )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    //  padding: EdgeInsets.all(8),
                    scrollDirection: Axis.vertical, //.horizontal
                    child: new Text(
                        '${description[0].toUpperCase()}${description.substring(1)}',
                        // requirment,
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      width: 10.0,
                      height: 10.0,
                    ),
                    new SizedBox(
                      width: 130.0,
                      height: 45.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 30,
                        child: Text(
                          ' OK ',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
