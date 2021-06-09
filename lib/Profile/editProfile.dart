import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '6_editprofile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String empid;
  final String email;
  final String work;
  final String mob;
  final String roleid;

  EditProfile(
      {Key key,
      @required this.name,
      this.empid,
      this.email,
      this.work,
      this.mob,
      this.roleid})
      : super(key: key);
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _empController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _mobController = new TextEditingController();

  Future updateProfile(
    String userIdd,
    String name,
    String empid,
    String email,
    String work,
    String mob,
  ) async {
    var data = {
      'id': userIdd,
      'name': name,
      'userId': empid,
      'email': email,
      'roleId': work,
      'mob_num': mob,
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/users/profileupdate',
        body: (data));
    if (response.statusCode == 200) {
      Toast.show("Updated Successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                          userId: sid,
                        )),
              ));
    } else {
      Toast.show("Something went wrong try again", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  int roleValue;
  bool roleError = false;
  Map mapResponse;
  List<dynamic> roleList;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get('http://isow.acutrotech.com/index.php/api/userRoles/rolesList');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        roleList = mapResponse['data'];
        print("{$roleList}");
      });
    }
  }

  setData() {
    _nameController.text = widget.name;
    _empController.text = widget.empid;
    _emailController.text = widget.email;
    _mobController.text = widget.mob;
  }

  Widget buildDropDownButton(String hint) {
    return DropdownButton(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      iconEnabledColor: Colors.black54,
      value: roleValue,
      isExpanded: true,
      underline: Container(
        height: 0,
        color: roleError ? Colors.red : Colors.white,
      ),
      hint: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          hint,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ),
      items: (roleList).map<DropdownMenuItem>((answer) {
        return DropdownMenuItem(
          value: int.parse(answer["id"]),
          child: Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              answer["userRoles"],
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          roleError = false;
          roleValue = value;

          print("$roleValue id of compny");
        });
        // print(companyValue.runtimeType);
      },
    );
  }

  @override
  void initState() {
    setData();
    fetchData();
    super.initState();
    getValidation();
  }

  String sid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    setState(() {
      sid = id;

      error = false;
    });
  }

  Widget textFieldBuild(TextEditingController contro) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),

      /// margin: EdgeInsets.all(20.0),
      // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
      height: 45.0,

      child: TextField(
        controller: contro,
        style: TextStyle(color: Colors.black54, fontSize: 12),
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
        ),
      ),
      body: mapResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Card(
                        margin: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(220),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        color: Color(0xFF4fc4f2),
                        child: new Container(
                          height: 250.0,
                          child: new Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                    radius: 39.0,
                                    child: Icon(Icons.camera_alt,
                                        size: 30.0, color: Colors.white),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Name : ' + widget.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(height: 5.0),
                                    // Text(
                                    //   'New york',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white,
                                    //       fontSize: 14.0),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        ListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          leading: MaterialButton(
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Color(0xFF4fc4f2),
                            child: Icon(
                              Icons.perm_identity,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          title: textFieldBuild(_nameController),
                          trailing: null,
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          leading: MaterialButton(
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Color(0xFF4fc4f2),
                            child: Icon(
                              Icons.person_pin_sharp,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          title: textFieldBuild(_empController),
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          leading: MaterialButton(
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Color(0xFF4fc4f2),
                            child: Icon(
                              Icons.mail_outline,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          title: textFieldBuild(_emailController),
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          leading: MaterialButton(
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Color(0xFF4fc4f2),
                            child: Icon(
                              Icons.work_outline_outlined,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          title: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),

                            /// margin: EdgeInsets.all(20.0),
                            // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                            height: 45.0,

                            child: buildDropDownButton(widget.work),
                          ),
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                          leading: MaterialButton(
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Color(0xFF4fc4f2),
                            child: Icon(
                              Icons.phone_android_outlined,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          title: textFieldBuild(_mobController),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                              if (_nameController.text == "" ||
                                  _empController.text == "" ||
                                  _emailController.text == "" ||
                                  _mobController.text == "") {
                                Toast.show("Enter all fields", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    textColor: Colors.blue,
                                    backgroundColor: Colors.white);
                              } else if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(_emailController.text) ==
                                  false) {
                                Toast.show("Enter valid Email id", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    textColor: Colors.blue,
                                    backgroundColor: Colors.white);
                              } else if (_mobController.text.length != 10) {
                                Toast.show("Enter Valid Mobile Number", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM,
                                    textColor: Colors.blue,
                                    backgroundColor: Colors.white);
                              } else {
                                if (roleValue == null) {
                                  updateProfile(
                                      sid,
                                      _nameController.text,
                                      _empController.text,
                                      _emailController.text,
                                      widget.roleid,
                                      _mobController.text);
                                } else {
                                  updateProfile(
                                      sid,
                                      _nameController.text,
                                      _empController.text,
                                      _emailController.text,
                                      roleValue.toString(),
                                      _mobController.text);
                                }
                              }
                            },
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
                                constraints: BoxConstraints(
                                    maxWidth: 150.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}
