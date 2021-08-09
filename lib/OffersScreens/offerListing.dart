import 'package:flutter/material.dart';
import 'package:isow/Widgects/alertBox.dart';
import 'offers_detail_Screen.dart';

class OfferDetailScreen extends StatefulWidget {
  static const routeName = "rig-screen";

  final List<dynamic> rigList;
  final String sid;
  final int id;
  final String title;

  OfferDetailScreen(
      {Key key, @required this.rigList, this.id, this.title, this.sid})
      : super(key: key);
  @override
  _OfferDetailScreenState createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
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
          centerTitle: true,
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
