import 'package:flutter/material.dart';

class CustomDialog {
  static void showSuccess(BuildContext context, String message) {
    _showDialog(context, 'Success', message, Icons.check_circle, Colors.green);
  }

  static void showConfirm(
      BuildContext context, String message, VoidCallback onConfirm) {
    _showDialog(
      context,
      'Confirm',
      message,
      Icons.help,
      Colors.blue,
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }

  static void showError(BuildContext context, String message) {
    _showDialog(context, 'Error', message, Icons.error, Colors.red);
  }

  static void showWarning(BuildContext context, String message) {
    _showDialog(context, 'Warning', message, Icons.warning, Colors.orange);
  }

  static void showNotification(BuildContext context, String message) {
    _showDialog(
        context, 'Notification', message, Icons.notifications, Colors.blue);
  }

  static void showInputDialog(
    BuildContext context,
    String title,
    String hintText,
    ValueChanged<String> onConfirm,
  ) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm(controller.text);
              },
            ),
          ],
        );
      },
    );
  }

  static void _showDialog(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color iconColor, {
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: actions ??
              [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
        );
      },
    );
  }
}
