import 'package:flutter/material.dart';

class DirectoryView extends StatelessWidget {
  final int index;
  final String rigId;
  final String rigName;
  final String rigDetails;

  DirectoryView(
    this.index,
    this.rigId,
    this.rigName,
    this.rigDetails,
  );
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
              // child: DecoratedBox(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage("assets/guest.png"), fit: BoxFit.cover),
              // ),
              child: Image.network(
                'https://googleflutter.com/sample_image.jpg',
                fit: BoxFit.fill,
              ),
              //),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(rigName,
                        style: const TextStyle(
                            height: 1, fontFamily: "FSSiena", fontSize: 24)),
                  ),
                  Text(rigId,
                      style: const TextStyle(
                          height: 1,
                          fontFamily: "FSSiena",
                          fontSize: 12,
                          color: Colors.black54)),
                ],
              ),
            ),
            SizedBox(height: 40),
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
