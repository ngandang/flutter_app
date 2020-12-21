import 'package:flutter/material.dart';

openDialog({
  BuildContext context,
  content,
  title = 'Alert',
  isCancel = false
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.8),
    barrierDismissible: false,

    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: Container(
          child: content
        ),
        actions: [
          isCancel ? TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ) : SizedBox(),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
