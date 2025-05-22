import 'package:flutter_base_getx/app/core/base/base_controller.dart';

class HomeController extends BaseController {
  // var image = Rxn<File>();
  // var recognizedText = ''.obs;
  // final ImagePicker _picker = ImagePicker();
  //
  // Future<void> pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(
  //     source: ImageSource.camera,
  //   );
  //   if (pickedFile != null) {
  //     image.value = File(pickedFile.path);
  //     recognizedText.value = '';
  //     isLoading.value = true;
  //     await runScanInIsolate(pickedFile.path);
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> runScanInIsolate(String path) async {
  //   final p = ReceivePort();
  //   await Isolate.spawn(_isolateScanText, [path, p.sendPort]);
  //   recognizedText.value = await p.first;
  // }
  //
  // static Future<void> _isolateScanText(List<dynamic> args) async {
  //   final String path = args[0];
  //   final SendPort sendPort = args[1];
  //
  //   final inputImage = InputImage.fromFilePath(path);
  //   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  //   final RecognizedText recognized = await textRecognizer.processImage(
  //     inputImage,
  //   );
  //   await textRecognizer.close();
  //
  //   sendPort.send(recognized.text);
  // }
}
