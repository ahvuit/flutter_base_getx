import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/di/injection.dart';

import '../logger/core_logger.dart';

class ImageUtils {
  static Widget loadImage(File? file, {double? width, double? height}) {
    if (file == null || !file.existsSync()) {
      getIt<CoreLogger>().w('Invalid or non-existent file provided.');
      return const Icon(Icons.broken_image);
    }
    getIt<CoreLogger>().d('Loading image from file: ${file.path}');
    return Image.file(
      file,
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        getIt<CoreLogger>().e('Failed to load image: $error', error, stackTrace);
        return const Icon(Icons.error);
      },
    );
  }

  static Widget loadNetworkImage(String? url, {double? width, double? height}) {
    if (url == null || url.isEmpty) {
      getIt<CoreLogger>().w('Invalid URL provided.');
      return const Icon(Icons.broken_image);
    }
    getIt<CoreLogger>().d('Loading network image: $url');
    return Image.network(
      url,
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        getIt<CoreLogger>().e('Failed to load network image: $error', error, stackTrace);
        return const Icon(Icons.error);
      },
    );
  }
}
