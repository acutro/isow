import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'offerListing.dart';

class NewsListingMain extends StatefulWidget {
  final List<dynamic> offerList;
  final String path;
  final String title;

  NewsListingMain({Key key, @required this.offerList, this.path, this.title})
      : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<NewsListingMain> {
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Icon(
            Icons.headset_mic,
            color: Colors.white38,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.logout,
            color: Colors.white38,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.menu,
            color: Colors.white38,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: widget.offerList == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: widget.offerList.length == 0
                    ? Center(child: Text("No Offers Available"))
                    : ListView.builder(
                        itemCount: widget.offerList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RigDetailScreen(
                                          title: widget.title,
                                          rigList: widget.offerList,
                                          id: index,
                                        )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      int.parse(widget.offerList[index]["id"]) %
                                                  2 ==
                                              0
                                          ? Color(0xFF4fc4f2).withOpacity(0.2)
                                          : Colors.white),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    padding: EdgeInsets.all(3),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xFF4fc4f2),
                                            child: Image.asset(widget.path),
                                          ),
                                          title: Text(
                                            widget.offerList[index]["title"],
                                            // '${listFacts[index]["created_at"][0].toUpperCase()}${listFacts[index]["created_at"].substring(1)}',
                                            //  listFacts[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.5),
                                          ),
                                          subtitle: Text(
                                            widget
                                                        .offerList[index]
                                                            ["description"]
                                                        .length >
                                                    120
                                                ? widget.offerList[index]
                                                        ["description"]
                                                    .substring(0, 120)
                                                : widget.offerList[index]
                                                    ["description"],
                                          ),
                                          // trailing: Text(
                                          //   listFacts[index]["description"]
                                          //       .substring(0, 10),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
