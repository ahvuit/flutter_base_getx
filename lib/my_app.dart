import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/utils/notification_utils.dart';
import 'package:flutter_base_getx/app/routes/app_pages.dart';
import 'package:flutter_base_getx/l10n/gen/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/core/constants/core_theme.dart';
import 'app/di/injection.dart';

void mainCommon(Flavor flavor) async {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      EnvConfig.initialize(flavor);
      FlutterNativeSplash.remove();
      configureDependencies();
      await NotificationUtils().initNotification(EnvConfig.instance);
      runApp(const MyApp());
    },
    (error, stackTrace) {
      if (kDebugMode) {
        print('runZonedGuarded: Caught error: $error');
      }
    },
  );
}

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
          title: EnvConfig.instance.appName,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('vi', 'VN'),
          fallbackLocale: const Locale('vi', 'VN'),
          theme: CoreTheme.lightTheme,
          darkTheme: CoreTheme.darkTheme,
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('AppLifecycleState.resumed');
        break;
      case AppLifecycleState.inactive:
        debugPrint('AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
        debugPrint('AppLifecycleState.paused');
        break;
      case AppLifecycleState.detached:
        debugPrint('AppLifecycleState.detached');
        break;
      case AppLifecycleState.hidden:
        debugPrint('AppLifecycleState.hidden');
    }
    super.didChangeAppLifecycleState(state);
  }
}
