import 'package:flutter/material.dart';

class BuildAlertDialogDelete extends StatelessWidget {
  final String errorMessage;
  final Function onTap;

  BuildAlertDialogDelete(this.errorMessage, this.onTap);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Delete?"),
      content: Text(errorMessage),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No")),
        FlatButton(
            onPressed: () {
              // ignore: unnecessary_statements
              onTap;
              Navigator.pop(context);
            },
            child: Text("Yes"))
      ],
    );
  }
}
