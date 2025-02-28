import 'dart:io';
import 'package:flutter/material.dart';
import '../logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class ImageUtils {
  static Widget loadImage(File file, {double? width, double? height}) {
    di.sl<CoreLogger>().d('Loading image from file: ${file.path}');
    return Image.file(
      file,
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        di.sl<CoreLogger>().e('Failed to load image: $error', error, stackTrace);
        return const Icon(Icons.error);
      },
    );
  }

  static Widget loadNetworkImage(String url, {double? width, double? height}) {
    di.sl<CoreLogger>().d('Loading network image: $url');
    return Image.network(
      url,
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        di.sl<CoreLogger>().e('Failed to load network image: $error', error, stackTrace);
        return const Icon(Icons.error);
      },
    );
  }
}