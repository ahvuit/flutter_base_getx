import 'dart:io';
import 'package:flutter/material.dart';
import '../logger/logger_service.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class ImageUtils {
  static Widget loadImage(File file, {double? width, double? height}) {
    di.sl<LoggerService>().d('Loading image from file: ${file.path}');
    return Image.file(
      file,
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        di.sl<LoggerService>().e('Failed to load image: $error', error, stackTrace);
        return const Icon(Icons.error);
      },
    );
  }

  static Widget loadNetworkImage(String url, {double? width, double? height}) {
    di.sl<LoggerService>().d('Loading network image: $url');
    return Image.network(
      url,
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        di.sl<LoggerService>().e('Failed to load network image: $error', error, stackTrace);
        return const Icon(Icons.error);
      },
    );
  }
}