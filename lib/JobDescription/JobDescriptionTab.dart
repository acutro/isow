import 'package:flutter/material.dart';
import 'jobDescriptionList.dart';
import 'jobExecutedList.dart';
import '22_jobdescription.dart';
import '21_jobdescriptionissuer.dart';
import 'jobHandoverList.dart';

class JobDescriptionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Job Description",
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
              color: Colors.white38,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.logout,
              color: Colors.white38,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.menu,
              color: Colors.white38,
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
                  icon: Icon(Icons.settings_applications, size: 30)),
              Tab(child: Text("Handover"), icon: Icon(Icons.refresh, size: 30)),
              // Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            JobDescriptionList(),
            JobExecutedList(),
            JobHandoverList(),

            // Icon(Icons.directions_car, size: 350),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Jobdescription()),
            );
          },
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: Text("Issue"),
        ),
      ),
    );
  }
}
