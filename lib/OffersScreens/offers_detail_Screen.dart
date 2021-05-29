import 'package:flutter/material.dart';

class DirectoryView extends StatelessWidget {
  final int index;
  final String rigId;
  final String rigName;
  final String rigDetails;
  final String path;
  String date;

  DirectoryView(this.index, this.rigId, this.rigName, this.rigDetails,
      this.path, this.date);
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 312,

              child: path == null
                  ? Image.asset(
                      'assets/images/offfer.png',
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      'http://isow.acutrotech.com/assets/images/offers/$path',
                      fit: BoxFit.fill,
                    ),
              //),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text(rigName, style: const TextStyle(fontSize: 22)),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text(
                  "Valid till\n" +
                      date.substring(0, 10) +
                      "." +
                      date.substring(10),
                  style: const TextStyle(fontSize: 14, height: 1.5)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(rigDetails,
                  style: const TextStyle(
                      height: 1.6,
                      color: Colors.black,
                      fontFamily: "FSSiena",
                      fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
