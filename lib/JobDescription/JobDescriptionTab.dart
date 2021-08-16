import 'package:flutter/material.dart';
import 'package:isow/Widgects/alertBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'issuedAuthority.dart';
import 'jobDescriptionList.dart';
import 'jobExecutedList.dart';
import 'jobHandoverList.dart';

class JobDescriptionTab extends StatefulWidget {
  @override
  _JobDescriptionTabState createState() => _JobDescriptionTabState();
}

class _JobDescriptionTabState extends State<JobDescriptionTab> {
  String sid;
  String posid;
  bool error = true;
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('userId');
    String pos = sharedPreferences.getString('position');
    setState(() {
      sid = id;
      posid = pos;

      error = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidation();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Work Management",
              style: TextStyle(
                color: Colors.white,
              ),
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
                    builder: (context) => BuildLogoutDialogclose(sid));
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
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Issued"),
                icon: Icon(Icons.contact_mail_outlined, size: 30),
              ),
              Tab(
                  child: Text("Execute"),
                  icon: Icon(Icons.handyman_outlined, size: 30)),
              Tab(
                  child: Text("Handover"),
                  icon: Icon(Icons.transfer_within_a_station, size: 30)),
              // Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
          ),
        ),
        body: TabBarView(
          children: [
            posid == '4' ? JobIssuedList() : JobDescriptionList(),
            JobExecutedList(),
            JobHandoverList(),

            // Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
