import 'package:flutter/material.dart';

class LoadingDialog {
  OverlayEntry? _overlayEntry;
  bool _isShowing = false;

  void show(BuildContext context) {
    if (_isShowing) return;

    _isShowing = true;
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              ModalBarrier(dismissible: false, color: Colors.black38),
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    if (!_isShowing || _overlayEntry == null) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }

  bool get isShowing => _isShowing;
}

final loadingDialog = LoadingDialog();
