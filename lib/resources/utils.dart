import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDateinFormat(String date, String format) {
  DateTime dateformatted = DateTime.parse(date);
  final DateFormat formatter = DateFormat(format);
  final String formatted = formatter.format(dateformatted);
  return formatted;
}

class ErrorResponse {
  late String type;
  late String message;
  ErrorResponse({String t = "Unknown", String m = "Something went wrong!"}) {
    type = t;
    message = m.replaceAll(RegExp(r'<(.*?)>'), "");
  }
}

Future<void> showErrorDialog(BuildContext context, ErrorResponse eresp) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(eresp.type),
        content: Text(eresp.message),
        actions: <Widget>[
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
