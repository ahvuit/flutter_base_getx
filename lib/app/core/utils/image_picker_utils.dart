import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../logger/core_logger.dart';
import 'permission_utils.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class ImagePickerUtils {
  static final _picker = ImagePicker();

  static Future<File?> pickImageFromCamera() async {
    if (await PermissionUtils.requestCameraPermission()) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        di.sl<CoreLogger>().i('Image picked from camera: ${pickedFile.path}');
        return File(pickedFile.path);
      }
    }
    di.sl<CoreLogger>().w('Image pick from camera failed or cancelled');
    return null;
  }

  static Future<File?> pickImageFromGallery() async {
    if (await PermissionUtils.requestStoragePermission()) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        di.sl<CoreLogger>().i('Image picked from gallery: ${pickedFile.path}');
        return File(pickedFile.path);
      }
    }
    di.sl<CoreLogger>().w('Image pick from gallery failed or cancelled');
    return null;
  }
}