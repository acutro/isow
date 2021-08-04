import 'package:flutter/material.dart';
import 'rigDetailScreen.dart';

class RigDetailScreen extends StatefulWidget {
  static const routeName = "rig-screen";
  final List<dynamic> rigList;
  final int flag;
  final int id;

  RigDetailScreen({
    Key key,
    @required this.rigList,
    this.flag,
    this.id,
  }) : super(key: key);
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
          centerTitle: true,
          title: Text(
            widget.flag == 0 ? 'Rigs details' : 'Material details',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFF4fc4f2), Colors.blue])),
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
          // actions: [
          //   Icon(
          //     Icons.headset_mic,
          //     color: Colors.white38,
          //   ),
          //   SizedBox(
          //     width: 5,
          //   ),
          //   Icon(
          //     Icons.logout,
          //     color: Colors.white38,
          //   ),
          //   SizedBox(
          //     width: 5,
          //   ),
          //   Icon(
          //     Icons.menu,
          //     color: Colors.white38,
          //   ),
          // ],
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
              if (widget.flag == 0) {
                return DirectoryView(
                  index,
                  widget.rigList[index]["rigId"],
                  widget.rigList[index]["rigName"],
                  widget.rigList[index]["details"],
                  widget.rigList[index]["rig_image"],
                  widget.flag,
                );
              } else {
                return DirectoryView(
                  index,
                  widget.rigList[index]["materialId"],
                  widget.rigList[index]["name"],
                  widget.rigList[index]["details"],
                  widget.rigList[index]["material_image"],
                  widget.flag,
                );
              }
            },
          ),
        ]));
  }
}
