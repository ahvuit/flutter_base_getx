import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Scanner'),
        centerTitle: true,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       Obx(() => controller.image.value != null
      //           ? Image.file(controller.image.value!, height: 200)
      //           : Container(
      //         height: 200,
      //         color: Colors.grey[300],
      //         child: const Center(child: Text('No image selected')),
      //       )),
      //       const SizedBox(height: 20),
      //       const Text('Recognized Text:', style: TextStyle(fontWeight: FontWeight.bold)),
      //       const SizedBox(height: 10),
      //       Obx(() => Expanded(
      //         child: SingleChildScrollView(
      //           child: Text(
      //             controller.recognizedText.isNotEmpty
      //                 ? controller.recognizedText.value
      //                 : 'Text will appear here',
      //           ),
      //         ),
      //       ))
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.pickImage,
      //   child: const Icon(Icons.camera_alt),
      // ),
    );
  }
}
