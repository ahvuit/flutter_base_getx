import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_getx/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Get.put<AppController>(AppController()).init(EnvironmentConfig.dev());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}