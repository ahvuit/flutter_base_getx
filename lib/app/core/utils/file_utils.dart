import 'dart:io';

import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:path_provider/path_provider.dart';

import '../logger/core_logger.dart';

class FileUtils {
  static Future<File> writeFile(String fileName, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    getIt<CoreLogger>().i('Writing to file: ${file.path}');
    return await file.writeAsString(content);
  }

  static Future<String?> readFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      getIt<CoreLogger>().i('Reading file: ${file.path}');
      return await file.readAsString();
    } else {
      getIt<CoreLogger>().w('File not found: ${file.path}');
      return null;
    }
  }

  static Future<void> deleteFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
      getIt<CoreLogger>().i('Deleted file: ${file.path}');
    }
  }
}