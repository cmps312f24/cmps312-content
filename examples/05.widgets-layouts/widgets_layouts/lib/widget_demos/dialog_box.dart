import 'package:flutter/material.dart';

Future<void> displayDialog({
  required BuildContext context,
  String title = "",
  required String message,
}) async {
  return showDialog<void>(
    context: context,
    // user must tap the ok button!
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(message)),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
