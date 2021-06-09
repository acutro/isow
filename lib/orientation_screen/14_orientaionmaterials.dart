import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'rigDetailpage.dart';

class OrientationMaterialScreen extends StatefulWidget {
  @override
  _OrientationMaterialScreenState createState() =>
      _OrientationMaterialScreenState();
}

class _OrientationMaterialScreenState extends State<OrientationMaterialScreen> {
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
      'name': name,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/SearchList/searchMaterials',
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
            'Orientation Materials',
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
                child: listFacts.length == 0
                    ? Center(child: Text("No Rigs found"))
                    : Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              // padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black45),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),

                              // width: MediaQuery.of(context).size.width*40,
                              child: ListTile(
                                // leading: new Icon(Icons.search),
                                title: TextFormField(
                                  controller: controller,
                                  decoration: new InputDecoration(
                                    hintText: 'Search',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    border: InputBorder.none,
                                    // fillColor: Colors.blue,
                                    // filled: true
                                  ),
                                  onChanged: (value) {
                                    fetchData(controller.text);
                                  },
                                ),
                                trailing: controller.text.isNotEmpty
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
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listFacts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: ListTile(
                                            leading: Image.network(
                                              'http://isow.acutrotech.com/assets/images/materials/' +
                                                  listFacts[index]
                                                      ['material_image'],
                                              width: 150.0,
                                              height: 150.0,
                                            ),
                                            title: Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      listFacts[index]['name'],
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
                                                          ['materialId'],
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
                                                              rigList:
                                                                  listFacts,
                                                              id: index,
                                                              flag: 1)),
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
