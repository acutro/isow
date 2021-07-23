import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class App extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
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
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('isowChat').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) return const Text("Loading..");
          return ListView.builder(
            itemCount: snapshots.data.docs.length,
            itemBuilder: (context, index) =>
                _buildListitem(context, snapshots.data.docs[index]),
          );
        },
      ),
    );
  }
}

Widget _buildListitem(BuildContext context, DocumentSnapshot document) {
  return ListTile(
    title: Row(
      children: [Expanded(child: Text(document['message'].toString()))],
    ),
  );
}
