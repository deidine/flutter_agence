import 'package:flutter/material.dart';

class MyAlertDialog {
  static void showAlertDialog(
      {required String title,required String message,required BuildContext myContext}) {
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                   ElevatedButton(
                    child: Text("ok", textScaleFactor: 1.5),
                    onPressed: () {
                      Navigator.pop(myContext);
                    },
                  ),
                ],
              ))
        ]);

    showDialog(context: myContext, builder: (_) => alertDialog);
  }
}
