import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:isow/Widgects/alertBox.dart';
import 'newsListingMain.dart';

class NewsListing extends StatefulWidget {
  final List<dynamic> newsList;
  final String sid;

  NewsListing({Key key, @required this.newsList, this.sid}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<NewsListing> {
  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = 'https://picsum.photos/250?image=9';

      return pathf;
    } else {
      pathf = 'http://isow.acutrotech.com/assets/images/news/' + path;
      return pathf;
    }
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
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
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              return showDialog(
                  context: context,
                  builder: (context) => BuildLogoutDialogclose(widget.sid));
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: widget.newsList == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: widget.newsList.length == 0
                    ? Center(child: Text("No News Available"))
                    : ListView.builder(
                        itemCount: widget.newsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsScreen(
                                          title: "News",
                                          rigList: widget.newsList,
                                          list: 2,
                                          id: index,
                                        )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      int.parse(widget.newsList[index]["id"]) %
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
                                            child: ClipOval(
                                              child: Image.network(
                                                  getpath(widget.newsList[index]
                                                      ["image_url"]),
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          title: Text(
                                            widget.newsList[index]["title"],
                                            // '${listFacts[index]["created_at"][0].toUpperCase()}${listFacts[index]["created_at"].substring(1)}',
                                            //  listFacts[index]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                height: 1.5),
                                          ),
                                          subtitle: Text(
                                            widget
                                                        .newsList[index]
                                                            ["description"]
                                                        .length >
                                                    40
                                                ? widget.newsList[index]
                                                        ["description"]
                                                    .substring(0, 40)
                                                : widget.newsList[index]
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
