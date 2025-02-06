import 'package:flutter/material.dart';

void showCustomOverlay(BuildContext context, {required Widget content}) {
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100,
      left: 50,
      right: 50,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
              SizedBox(height: 10),
              TextButton(
                onPressed: () => overlayEntry?.remove(),
                child: Text('Close', style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);
}