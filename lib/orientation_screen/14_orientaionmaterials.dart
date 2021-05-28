import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'rigDetailpage.dart';

class OrientationMaterialScreen extends StatefulWidget {
  @override
  _OrientationMaterialScreenState createState() =>
      _OrientationMaterialScreenState();
}

class _OrientationMaterialScreenState extends State<OrientationMaterialScreen> {
  List<dynamic> mineralList;

  Future<List<Employee>> _getEmployee() async {
    var empData = await http.get(
        "http://isow.acutrotech.com/index.php/api/orientation/materialList");
    Map jsonData = json.decode(empData.body);

    List<Employee> employees = [];
    jsonData["data"].forEach((f) {
      Employee employee = Employee(
          id: f["id"],
          materialId: f["materialId"],
          name: f["name"],
          details: f["details"]);
      employees.add(employee);
      setState(() {
        mineralList = jsonData["data"];
      });
    });
    return employees;
  }

  @override
  void initState() {
    super.initState();
    _getEmployee();
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
      body: FutureBuilder(
          future: _getEmployee(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              print(snapshot.data.length);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: ListTile(
                        leading: Image.network(
                          'https://googleflutter.com/sample_image.jpg',
                          width: 150.0,
                          height: 150.0,
                        ),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: RaisedButton(
                          color: Color(0xFF4fc4f2),
                          textColor: Colors.white,
                          child: Text('More Details'),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RigDetailScreen(
                                      rigList: mineralList,
                                      id: index,
                                      flag: 1)),
                            ),
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        )),
                  );
                },
              );
            }
          }),
    );
  }
}

class Employee {
  final String id;
  final String materialId;
  final String name;
  final String details;

  Employee({this.id, this.materialId, this.name, this.details});
}
