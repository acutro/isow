import 'dart:async';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:toast/toast.dart';
import 'dart:io' as file;

import 'package:async/async.dart';

class RegScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<RegScreen> {
  int roleValue;
  bool roleError = false;
  int rigValue;
  bool rigError = false;
  Map roleResponse;
  Map rigResponse;
  Map regResponse;
  List<dynamic> roleList;
  List<dynamic> rigList;
  file.File fileup;
  String path;
  String name;
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  void openGallery() async {
    _paths = null;
    var selectfile = await FilePicker.getFile(type: FileType.any);

    if (!mounted) return;
    setState(() {
      _path = selectfile.path;
      fileup = selectfile;
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null
              ? _paths.keys.toString()
              : 'Choose File';
    });
  }

  Future fetchRig() async {
    http.Response response;
    response = await http.get(ListingApi.rigListApi);
    if (response.statusCode == 200) {
      setState(() {
        rigResponse = jsonDecode(response.body);
        rigList = rigResponse['data'];

        rigFn(rigList);
        print("{$rigList}");
      });
    }
  }

  List<String> rigDropList = [];
  rigFn(List rigListt) {
    for (int i = 0; i < rigListt.length; i++) {
      setState(() {
        rigDropList.add(rigListt[i]['rigName']);
      });
    }
  }

  Future fetchRole() async {
    http.Response response;
    response = await http.get(ListingApi.roleListApi);
    if (response.statusCode == 200) {
      setState(() {
        roleResponse = jsonDecode(response.body);
        roleList = roleResponse['data'];

        roleFn(roleList);
        print("{$roleList}");
      });
    }
  }

  List<String> roleDList = [];
  roleFn(List roleListt) {
    for (int i = 0; i < roleListt.length; i++) {
      setState(() {
        roleDList.add(roleListt[i]['userRoles']);
      });
    }
  }

  String roleName;
  String rigName;
  Widget buildRoleDropDownn() {
    return DropDownField(
      onValueChanged: (dynamic value) {
        setState(() {
          roleName = value;
        });
      },

      strict: true,

      hintStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 12.0),
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 12.0),
      value: roleName,
      // required: false,
      hintText: 'Select Role',
      items: roleDList,
    );
  }

  Widget buildRigDropDownn() {
    return DropDownField(
      onValueChanged: (dynamic value) {
        setState(() {
          rigName = value;
        });
      },

      strict: true,

      hintStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 12.0),
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 12.0),
      value: rigName,
      // required: false,
      hintText: 'Select Rig',
      items: rigDropList,
    );
  }

  String roleStatusFn(String roleNamepass) {
    String id;
    for (int i = 0; i < roleList.length; i++) {
      if (roleList[i]['userRoles'] == roleNamepass) {
        setState(() {
          id = roleList[i]['id'].toString();
        });
      }
    }
    return id;
  }

  String rigStatusFn(String rigNamepass) {
    String id;
    for (int i = 0; i < rigList.length; i++) {
      if (rigList[i]['rigName'] == rigNamepass) {
        setState(() {
          id = rigList[i]['id'].toString();
        });
      }
    }
    return id;
  }

  Future<void> userReg(
    String name,
    String userIdd,
    String email,
    String pass,
    String mob,
    String rigId,
    String roleId,
    file.File images,
  ) async {
    var uri = Uri.parse(UserAuthApi.userRegisterApi);
    print("image upload URL - $uri");
// create multipart request
    var request = new http.MultipartRequest("POST", uri);

    if (images == null) {
      request.fields['name'] = name;
      request.fields['userId'] = userIdd;
      request.fields['email'] = email;
      request.fields['password'] = pass;
      request.fields['cpassword'] = pass;
      request.fields['roleId'] = roleId;
      request.fields['rigId'] = rigId;
      request.fields['work'] = 'work';
      request.fields['mob_num'] = mob;
    } else {
      String fileName = images.path.split("/").last;
      var stream =
          new http.ByteStream(DelegatingStream.typed(images.openRead()));
      var length = await images.length();
      request.files.add(new http.MultipartFile('profile_pic', stream, length,
          filename: fileName));
      request.fields['name'] = name;
      request.fields['userId'] = userIdd;
      request.fields['email'] = email;
      request.fields['password'] = pass;
      request.fields['cpassword'] = pass;
      request.fields['roleId'] = roleId;
      request.fields['rigId'] = rigId;
      request.fields['work'] = 'work';
      request.fields['mob_num'] = mob;
    }

    var response = await request.send();
    print("end ");
    print("${response.statusCode} status code of service request");

    if (response.statusCode == 200) {
      Toast.show("Job added successfully", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.green[600],
          backgroundColor: Colors.white);
      Timer(Duration(seconds: 1), () => Navigator.pop(context));
    } else {
      print(regResponse['message']);
      Toast.show(regResponse['message'], context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
      Timer(Duration(seconds: 1), () => Navigator.pop(context));
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _useridController = new TextEditingController();
  TextEditingController _cpasswordController = new TextEditingController();
  TextEditingController _mobController = new TextEditingController();

  void _viewPass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _viewPass2() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  bool _obscureText = true;
  bool _obscureText1 = true;
  @override
  void initState() {
    super.initState();
    fetchRig();
    fetchRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Registration',
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF4fc4f2), Colors.blue]),
          ),
        ),
      ),
      body: roleResponse == null || rigResponse == null
          ? Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 120,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Container(
                            //   height: 110.0,
                            //   width: 110.0,
                            //   child: Image.asset('assets/images/logo.png'),
                            // ),
                            Text(
                              'User Registration',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontFamily: "WorkSansLight"),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              controller: _nameController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black45,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "enter the name";
                                }
                                return null;
                              },
                              onSaved: (String name) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              controller: _useridController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.perm_identity_sharp,
                                  color: Colors.black45,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Employee Id",
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter Employee Id";
                                }
                                if (value.length != 6) {
                                  return "Please 6 Digit Employee Id";
                                }
                                return null;
                              },
                              onSaved: (String userid) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              controller: _emailController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black45,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter  email";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                              onSaved: (String email) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              controller: _mobController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.mobile_friendly,
                                  color: Colors.black45,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter Mobile Number";
                                }
                                if (value.length != 10) {
                                  return "Please enter valid Mobile Number";
                                }
                                return null;
                              },
                              onSaved: (String userid) {},
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: Colors.black45)),
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              child: buildRoleDropDownn()),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: Colors.black45)),
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              child: buildRigDropDownn()),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _viewPass();
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.lock_sharp
                                        : Icons.lock_open_outlined,
                                    color: Colors.black45,
                                  ),
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.black45)),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              controller: _cpasswordController,
                              obscureText: _obscureText1,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _viewPass2();
                                  },
                                  child: Icon(
                                    _obscureText1
                                        ? Icons.lock_sharp
                                        : Icons.lock_open_outlined,
                                    color: Colors.black45,
                                  ),
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontFamily: "WorkSansLight"),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter re-password";
                                }
                                if (_passwordController.text !=
                                    _cpasswordController.text) {
                                  return "Password Do not match";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 1, color: Colors.black45)),
                                    margin: new EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _fileName == null
                                              ? Text("Choose File")
                                              : Text(_fileName.length > 20
                                                  ? _fileName
                                                          .toString()
                                                          .substring(0, 20) +
                                                      "..."
                                                  : _fileName.toString()),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            openGallery();
                                          },
                                          child: Text("Select"),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            userReg(
                                _nameController.text,
                                _useridController.text,
                                _emailController.text,
                                _passwordController.text,
                                _mobController.text,
                                rigStatusFn(rigName),
                                roleStatusFn(roleName),
                                fileup
                                // rigValue.toString(),
                                // roleValue.toString()
                                );

                            print("Successful");
                          } else {
                            AlertDialog(
                              title: Text("UnSuccessful"),
                            );
                            print("Unsuccessfull");
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Colors.blue[600],
                              // gradient: LinearGradient(
                              //   colors: [Color(0xFF4fc4f2), Colors.blue],
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              // ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 170.0, minHeight: 50.0),
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
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //     child: FlatButton(
                    //   textColor: Colors.white,
                    //   child: Text.rich(
                    //     TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: 'Back to ',
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontFamily: "WorkSansLight",
                    //           ),
                    //         ),
                    //         TextSpan(
                    //           text: 'sign in.',
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             fontFamily: "WorkSansLight",
                    //             decoration: TextDecoration.underline,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => SigninScreen()));

                    //     //signup screen
                    //   },
                    // )),
                  ],
                ),
              ),
            ),
    );
  }
}
