import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class FileUtils {
  static Future<File> writeFile(String fileName, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    di.sl<CoreLogger>().i('Writing to file: ${file.path}');
    return await file.writeAsString(content);
  }

  static Future<String?> readFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      di.sl<CoreLogger>().i('Reading file: ${file.path}');
      return await file.readAsString();
    } else {
      di.sl<CoreLogger>().w('File not found: ${file.path}');
      return null;
    }
  }

  static Future<void> deleteFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
      di.sl<CoreLogger>().i('Deleted file: ${file.path}');
    }
  }
}