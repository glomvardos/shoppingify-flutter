import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.cancelButtonText,
    required this.confirmButtonText,
  }) : super(key: key);

  final String title;
  final String content;
  final String cancelButtonText;
  final String confirmButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          child: Text(cancelButtonText),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Text(confirmButtonText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
