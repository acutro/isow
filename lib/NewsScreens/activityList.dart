import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:isow/Widgects/alertBox.dart';
import 'dart:convert';
import 'newsListingMain.dart';

class ActivityListing extends StatefulWidget {
  final String cat;
  final String sid;

  ActivityListing({Key key, @required this.cat, this.sid}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<ActivityListing> {
  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/Activities/list');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        print("{$listFacts}");
      });
    }
  }

  List<dynamic> chooseCtogory(List<dynamic> listt, String id) {
    List lis = listt.where((o) => o['category_id'] == id).toList();
    return lis;
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    fetchData();
  }

  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = 'https://picsum.photos/250?image=9';

      return pathf;
    } else {
      pathf = 'http://isow.acutrotech.com/assets/images/activities/' + path;
      return pathf;
    }
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Activities",
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
        child: mapResponse == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: listFacts.length == 0
                    ? Center(child: Text("No Activities Available"))
                    : ListView.builder(
                        itemCount: widget.cat == '0'
                            ? listFacts.length
                            : chooseCtogory(listFacts, widget.cat).length,
                        itemBuilder: (BuildContext context, int index) {
                          // final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsScreen(
                                          title: "Activities",
                                          rigList: widget.cat == '0'
                                              ? listFacts
                                              : chooseCtogory(
                                                  listFacts, widget.cat),
                                          list: 1,
                                          id: index,
                                        )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: int.parse(widget.cat == '0'
                                                  ? listFacts[index]["id"]
                                                  : chooseCtogory(listFacts,
                                                          widget.cat)[index]
                                                      ["id"]) %
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
                                              backgroundColor:
                                                  Color(0xFF4fc4f2),
                                              child: ClipOval(
                                                child: Image.network(
                                                    widget.cat == '0'
                                                        ? getpath(
                                                            listFacts[index]
                                                                ["image_url"])
                                                        : getpath(chooseCtogory(
                                                                listFacts,
                                                                widget
                                                                    .cat)[index]
                                                            ["image_url"]),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            title: Text(
                                              widget.cat == '0'
                                                  ? listFacts[index]["category"]
                                                  : chooseCtogory(listFacts,
                                                          widget.cat)[index]
                                                      ["category"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5),
                                            ),
                                            subtitle: widget.cat == '0'
                                                ? Text(listFacts[index]["description"].length > 40
                                                    ? listFacts[index]
                                                            ["description"]
                                                        .substring(0, 40)
                                                    : listFacts[index]
                                                        ["description"])
                                                : Text(chooseCtogory(listFacts, widget.cat)[index]
                                                                ["description"]
                                                            .length >
                                                        40
                                                    ? chooseCtogory(listFacts, widget.cat)[index]
                                                            ["description"]
                                                        .substring(0, 40)
                                                    : chooseCtogory(
                                                            listFacts, widget.cat)[index]
                                                        ["description"])),
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
