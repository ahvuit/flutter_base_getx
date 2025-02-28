import 'package:flutter/material.dart';

/// A base screen widget that provides common functionality for all screens.
abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  /// Override this method to build the screen's UI.
  Widget buildScreen(BuildContext context);

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
