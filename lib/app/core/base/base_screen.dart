import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/widget/custom_dialog.dart';

/// A base screen widget that provides common functionality for all screens.
abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  /// Override this method to build the screen's UI.
  Widget buildScreen(BuildContext context);

  /// Shows a loading indicator.
  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  /// Hides the loading indicator.
  void hideLoading() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Shows an error message.
  void showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
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

  /// Shows a custom input dialog.
  void showInputDialog(
      String title, String hintText, ValueChanged<String> onConfirm) {
    CustomDialog.showInputDialog(context, title, hintText, onConfirm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: buildScreen(context),
    );
  }
}
