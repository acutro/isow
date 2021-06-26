import 'package:flutter/material.dart';
import 'offers_detail_Screen.dart';

class RigDetailScreen extends StatefulWidget {
  static const routeName = "rig-screen";

  final List<dynamic> rigList;

  final int id;
  final String title;

  RigDetailScreen({Key key, @required this.rigList, this.id, this.title})
      : super(key: key);
  @override
  _RigDetailScreenState createState() => _RigDetailScreenState();
}

class _RigDetailScreenState extends State<RigDetailScreen> {
  int pageChanged;

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
        appBar: AppBar(
          title: Text(
            widget.title,
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
        ),
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
                widget.rigList[index]["category_id"].toString(),
                widget.rigList[index]["title"],
                widget.rigList[index]["description"],
                widget.rigList[index]["image_url"],
                widget.rigList[index]["end_date"],
              );
            },
          ),
        ]));
  }
}
