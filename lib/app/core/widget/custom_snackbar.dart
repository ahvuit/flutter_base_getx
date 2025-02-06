import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, {required String message, Color? backgroundColor, Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(fontSize: 14)),
      backgroundColor: backgroundColor ?? Colors.blueGrey,
      duration: duration ?? Duration(seconds: 2),
    ),
  );
}