import 'package:flutter/material.dart';
import 'package:navi_task/other/constants.dart';

showAlertDialog(BuildContext context, int id) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text('Operation Success')),
    content: Container(
      height: 100,
      child: Center(
        child: Column(
          children: [
            Icon(Icons.done , color:kButtonColor , size: 50,),
            Text("Your Trip ID $id"),
          ],
        ),
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
