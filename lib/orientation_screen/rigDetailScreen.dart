import 'package:flutter/material.dart';

class DirectoryView extends StatelessWidget {
  final int index;
  final String rigId;
  final String rigName;
  final String rigDetails;
  final String path;
  final int list;

  DirectoryView(this.index, this.rigId, this.rigName, this.rigDetails,
      this.path, this.list);
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                        : list == 0
                            ? Image.network(
                                'http://isow.acutrotech.com/assets/images/rigs/$path',
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                'http://isow.acutrotech.com/assets/images/materials/$path',
                                fit: BoxFit.fill,
                              )),
                Positioned(
                    left: 0,
                    top: 100,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50,
                      color: Colors.white24,
                    )),
                Positioned(
                    top: 100,
                    right: 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 50,
                      color: Colors.white24,
                    )),
              ],
            ),

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
                  list == 0 ? "Rig id : " + rigId : "Material id : " + rigId,
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
            )

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.65,
            //         child: Text(rigName,
            //             style: const TextStyle(
            //                 height: 1, fontFamily: "FSSiena", fontSize: 24)),
            //       ),
            //       Text(rigId,
            //           style: const TextStyle(
            //               height: 1,
            //               fontFamily: "FSSiena",
            //               fontSize: 12,
            //               color: Colors.black54)),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 40),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: Text(rigDetails,
            //       style: const TextStyle(
            //           height: 1.6,
            //           color: Colors.black,
            //           fontFamily: "FSSiena",
            //           fontSize: 16)),
            // )
          ],
        ),
      ),
    );
  }
}
