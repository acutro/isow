import 'package:flutter/material.dart';
import 'package:isow/ApiUtils/apiUtils.dart';

// ignore: must_be_immutable
class NewsDetailsView extends StatelessWidget {
  final int index;
  final int list;
  final String rigName;
  final String rigDetails;
  final String path;
  String date;

  NewsDetailsView(this.index, this.list, this.rigName, this.rigDetails,
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
                height: 250,
                decoration: new BoxDecoration(
                    color: const Color(0xFF66BB6A),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                      ),
                    ]),
                child: path == null
                    ? Image.asset(
                        'assets/images/offfer.png',
                        fit: BoxFit.fill,
                      )
                    : list == 1
                        ? Image.network(
                            ApifeedbackNews.activityImageApi + path,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            ApifeedbackNews.newsImageApi + path,
                            fit: BoxFit.fill,
                          )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(rigName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                  "Valid till : " +
                      date.substring(0, 10) +
                      "." +
                      date.substring(10),
                  style: const TextStyle(fontSize: 14, height: 1.5)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(rigDetails,
                  style: const TextStyle(
                      height: 1.6,
                      color: Colors.black,
                      fontFamily: "FSSiena",
                      fontSize: 16)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
