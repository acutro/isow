import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'rigDetailpage.dart';

class OrientationRigScreen extends StatefulWidget {
  @override
  _OrientationRigScreenState createState() => _OrientationRigScreenState();
}

class _OrientationRigScreenState extends State<OrientationRigScreen> {
  String sid;
  TextEditingController controller = new TextEditingController();
  bool error = true;
  // Future getValidation() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String id = sharedPreferences.getString('userId');

  //   setState(() {
  //     sid = id;

  //     fetchIssued(id);
  //     error = false;
  //   });
  // }

  List listResponse;
  Map mapResponse;
  List<dynamic> listFacts;
  bool jobError = false;
  Future fetchData(String name) async {
    var data = {
      'rigName': name,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SearchList/searchRigs',
        body: (data));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listFacts = mapResponse['data'];
        jobError = false;
        print("{$listFacts}");
      });
    } else {
      jobError = true;

      Toast.show("Something went Wrong", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future<Null> refreshList(String nam) async {
    await Future.delayed(Duration(seconds: 2));
    //  getValidation();
    fetchData(nam);
  }

  @override
  void initState() {
    // getValidation();
    fetchData("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rigs Details',
          ),
        ),
        actions: [
          Icon(Icons.headset_mic),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.logout),
          SizedBox(
            width: 10,
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          refreshList(controller.text);
        },
        child: jobError == true || mapResponse == null
            ? Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 120,
                ),
              )
            : Container(
                decoration:
                    BoxDecoration(color: Color(0xFF4fc4f2).withOpacity(0.2)),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: listFacts == null
                    ? Center(child: Text("No Rig details found"))
                    : Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: Colors.grey[600])),
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  fetchData(controller.text);
                                },
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                                controller: controller,
                                decoration: new InputDecoration(
                                  suffixIcon: controller.text.isNotEmpty
                                      ? new IconButton(
                                          icon: new Icon(Icons.cancel),
                                          onPressed: () {
                                            controller.clear();
                                            fetchData(controller.text);
                                            // providerData.getContacts();
                                            // onSearchTextChanged('');
                                          },
                                        )
                                      : Icon(Icons.search),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'Search',
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    itemCount: listFacts.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: ListTile(
                                            leading: Image.network(
                                              'http://isow.acutrotech.com/assets/images/rigs/' +
                                                  listFacts[index]['rig_image'],
                                              width: 150.0,
                                              height: 150.0,
                                            ),
                                            title: Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      listFacts[index]['rigId'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      listFacts[index]
                                                          ['rigName'],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            subtitle: RaisedButton(
                                              color: Color(0xFF4fc4f2),
                                              textColor: Colors.white,
                                              child: Text('More Details'),
                                              onPressed: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RigDetailScreen(
                                                            rigList: listFacts,
                                                            id: index,
                                                            flag: 0,
                                                          )),
                                                ),
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
