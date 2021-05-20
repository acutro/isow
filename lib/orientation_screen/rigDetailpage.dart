import 'package:flutter/material.dart';
import 'package:isow/orientation_screen/13_OrientationRigs.dart';
import 'rigDetailScreen.dart';

class RigDetailScreen extends StatefulWidget {
  static const routeName = "rig-screen";
  final List<dynamic> rigList;

  final int id;

  RigDetailScreen({
    Key key,
    @required this.rigList,
    this.id,
  }) : super(key: key);
  @override
  _RigDetailScreenState createState() => _RigDetailScreenState();
}

class _RigDetailScreenState extends State<RigDetailScreen> {
  int pageChanged;
  // bool checkInternet;
  // List guestDirectoryDetailList;

  @override
  void initState() {
    super.initState();
  }

  // int getIndex( int id) {
  //   for (int i = 0; i < 10; i++) {
  //     if (widget.rigList[i]["id"] == widget.id) {
  //       return i;
  //     }
  //   }
  // }

  PageController pageController;
  //  = PageController(initialPage: widget.id);
  @override
  Widget build(BuildContext context) {
    pageController = PageController(initialPage: widget.id);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          PageView.builder(
            pageSnapping: true,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageChanged = index;
              });
            },
            itemCount: widget.rigList.length,
            itemBuilder: (BuildContext context, int index) {
              return DirectoryView(
                  index,
                  widget.rigList[index]["rigId"],
                  widget.rigList[index]["rigName"],
                  widget.rigList[index]["details"]);
            },
          ),
        ]));
  }
}
