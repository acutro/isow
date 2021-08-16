import 'package:flutter/material.dart';
import 'package:isow/ApiUtils/apiUtils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetail extends StatefulWidget {
  final String email;
  final String mob;
  final String work;
  final String name;
  final String id;
  final String ppath;
  ContactDetail(
      {Key key,
      @required this.email,
      this.mob,
      this.work,
      this.name,
      this.id,
      this.ppath})
      : super(key: key);
  @override
  _ContactDetail createState() => _ContactDetail();
}

class _ContactDetail extends State<ContactDetail> {
  getpath(String path) {
    var pathf;
    if (path == "") {
      pathf = UserAuthApi.profileImageApi + 'default.png';

      return pathf;
    } else {
      pathf = pathf = UserAuthApi.profileImageApi + path;
      return pathf;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text(widget.name),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100000),
                  child: CircleAvatar(
                    radius: 80,
                    child: Image.network(getpath(widget.ppath),
                        height: 300, width: 300, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  widget.name,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              ListTile(
                subtitle: Text(
                  widget.id,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                title: Text(
                  "User ID",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(18),
                  child: Icon(Icons.person),
                ),
              ),
              Divider(),
              ListTile(
                subtitle: Text(
                  widget.mob,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                title: Text(
                  "Mobile",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                trailing: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    launch("tel:" + widget.mob);
                  },
                  child: Container(
                    padding: EdgeInsets.all(18),
                    child: Icon(Icons.call),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                subtitle: Text(
                  widget.email,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                title: Text(
                  "Email",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(18),
                  child: Icon(Icons.email),
                ),
              ),
              Divider(),
              ListTile(
                subtitle: Text(
                  '${widget.work[0].toUpperCase()}${widget.work.substring(1)}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                title: Text(
                  "Position",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(18),
                  child: Icon(Icons.work),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
