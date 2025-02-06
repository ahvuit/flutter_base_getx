import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, child) {
          return GetMaterialApp(
            title: "FEC_CHAT_PLATFORM",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
