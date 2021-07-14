import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'JobDescriptionTab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:toast/toast.dart';
import 'dart:io' as file;
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';

class Jobdescription extends StatefulWidget {
  final String userId;

  Jobdescription({Key key, @required this.userId}) : super(key: key);
  @override
  _JobdescriptionState createState() => _JobdescriptionState();
}

class _JobdescriptionState extends State<Jobdescription> {
  TextEditingController _descriptionController = new TextEditingController();

  TextEditingController _durationController = new TextEditingController();
  int roleValue;
  bool roleError = false;
  int userValue;
  bool userError = false;
  Map mapResponse;
  Map userResponse;
  List<dynamic> roleList;
  List<dynamic> userList;
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

  Future fetchUsers(
    int id,
  ) async {
    var data = {
      'roleId': id.toString(),
    };
    http.Response response;
    response = await http.post(
        'http://isow.acutrotech.com/index.php/api/UserRoles/usersList',
        body: (data));
    if (response.statusCode == 200) {
      setState(() {
        userResponse = jsonDecode(response.body);
        userList = userResponse['data'];
        print("{$userList}");
      });
    } else {
      setState(() {
        userList.clear();
      });
      Toast.show("List is Empty", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  Future<void> postJobissue(
    String id,
    String description,
    String duration,
    file.File images,
  ) async {
    var uri =
        Uri.parse("http://isow.acutrotech.com/index.php/api/JobIssue/create");
    print("image upload URL - $uri");
// create multipart request
    var request = new http.MultipartRequest("POST", uri);
    if (images == null) {
      request.fields['file_url'] = "";
      request.fields['assignedBy'] = widget.userId;
      request.fields['assignedTo'] = id;
      request.fields['job_description'] = description;
      request.fields['duration'] = duration;
    } else {
      String fileName = images.path.split("/").last;
      var stream =
          new http.ByteStream(DelegatingStream.typed(images.openRead()));
      var length = await images.length();
      request.files.add(new http.MultipartFile('file_url', stream, length,
          filename: fileName));
      request.fields['assignedBy'] = widget.userId;
      request.fields['assignedTo'] = id;
      request.fields['job_description'] = description;
      request.fields['duration'] = duration;
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
      Timer(
          Duration(seconds: 1),
          () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => JobDescriptionTab()),
              ));
    } else {
      Toast.show("Something went wrong try again", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          textColor: Colors.red,
          backgroundColor: Colors.white);
    }
  }

  // Future postJob(
  //   String id,
  //   String description,
  //   String duration,
  // ) async {
  //   var data = {
  //     'assignedBy': widget.userId,
  //     'assignedTo': id,
  //     'job_description': description,
  //     'duration': duration
  //   };
  //   http.Response response;
  //   response = await http.post(
  //       'http://isow.acutrotech.com/index.php/api/JobIssue/create',
  //       body: (data));
  //   if (response.statusCode == 200) {
  //     Toast.show("Job added successfully", context,
  //         duration: Toast.LENGTH_SHORT,
  //         gravity: Toast.BOTTOM,
  //         textColor: Colors.green[600],
  //         backgroundColor: Colors.white);
  //     Timer(
  //         Duration(seconds: 1),
  //         () => Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(builder: (context) => JobDescriptionTab()),
  //             ));
  //   } else {
  //     Toast.show("Failed", context,
  //         duration: Toast.LENGTH_SHORT,
  //         gravity: Toast.BOTTOM,
  //         textColor: Colors.red,
  //         backgroundColor: Colors.white);
  //   }
  // }

  Widget buildDropDownButton() {
    return Container(
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: DropdownButton(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        iconEnabledColor: Colors.black87,
        value: roleValue,
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(
          height: 0,
          color: roleError ? Colors.red : Colors.black87,
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            "Role",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
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
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            fetchUsers(value);
            roleError = false;
            roleValue = value;

            print("$roleValue id of compny");
          });
          // print(companyValue.runtimeType);
        },
      ),
    );
  }

  Widget personDropDownButton() {
    return Container(
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      // color: Color.fromRGBO(221, 193, 135, 0.08),
      child: userResponse == null
          ? GestureDetector(
              onTap: () {
                Toast.show("Select Person", context,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM,
                    textColor: Colors.red,
                    backgroundColor: Colors.black87);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  "Select Employee",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ))
          : DropdownButton(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              iconEnabledColor: Colors.black87,
              value: userValue,
              dropdownColor: Colors.white,
              isExpanded: true,
              underline: Container(
                height: 0,
                color: userError ? Colors.red : Colors.black87,
              ),
              hint: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Employee Name",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              items: (userList).map<DropdownMenuItem>((answer) {
                return DropdownMenuItem(
                  value: int.parse(answer["id"]),
                  child: Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      answer["name"],
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  userError = false;
                  userValue = value;
                  print("$userValue id of compny");
                });
                // print(companyValue.runtimeType);
              },
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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

  // Future openCamera(String id) async {
  //   var image = await ImagePicker.pickImage(
  //       maxHeight: 640,
  //       maxWidth: 480,
  //       source: ImageSource.camera,
  //       imageQuality: 10);
  //   // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null)
  //     setState(() {
  //       newImage = image;
  //       name = image.path.split('/').last;
  //       path = image.path;
  //       //   profileUpdate(id, newImage);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff49A5FF),
        title: Text(' Issue a Job'),
        centerTitle: true,
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff49A5FF),
                              borderRadius: BorderRadius.circular(50.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 80.0,
                            width: 80.0,
                            child: Icon(
                              Icons.contact_mail_outlined,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 470.0,
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
                                      height: 45.0,
                                      child: buildDropDownButton(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 0.0),
                                      height: 45.0,
                                      child: personDropDownButton(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black45, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  margin: EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 0.0),
                                  height: 45.0,
                                  child: TextField(
                                    controller: _descriptionController,
                                    style: TextStyle(color: Colors.black87),
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      hintText: 'Job Description',
                                      hintStyle:
                                          TextStyle(color: Colors.black87),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                height: 45.0,
                                child: TextField(
                                  controller: _durationController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                    hintText: 'Duration in Hour',
                                    hintStyle: TextStyle(color: Colors.black87),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //
                              //

                              //
                              //
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black45, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        margin: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 0.0),
                                        height: 45.0,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _fileName == null
                                                  ? Text("Choose File")
                                                  : Text(_fileName.length > 20
                                                      ? _fileName
                                                              .toString()
                                                              .substring(
                                                                  0, 20) +
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
                                height: 15,
                              ),
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        20.0, 0.0, 20.0, 0.0),
                                    height: 40.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),

                                    //margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (userValue == null) {
                                    Toast.show("Select from Dropdown", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        textColor: Color(0xff49A5FF),
                                        backgroundColor: Colors.white);
                                  } else if (_descriptionController.text ==
                                          "" ||
                                      _durationController.text == "") {
                                    Toast.show("Enter Description and Duration",
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        textColor: Color(0xff49A5FF),
                                        backgroundColor: Colors.white);
                                  } else {
                                    postJobissue(
                                        userValue.toString(),
                                        _descriptionController.text,
                                        _durationController.text,
                                        fileup);

                                    setState(() {
                                      _descriptionController.text = "";
                                      _durationController.text = "";
                                    });
                                    // Navigator.pop(context);

                                  }
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
