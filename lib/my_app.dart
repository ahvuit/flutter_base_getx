import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/utils/notification_utils.dart';
import 'package:flutter_base_getx/app/core/utils/screen_utils.dart';
import 'package:flutter_base_getx/app/routes/app_pages.dart';
import 'package:flutter_base_getx/l10n/gen/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/core/themes/app_theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

void mainCommon(Flavor flavor) async {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    EnvConfig.initialize(flavor);
    await NotificationUtils().initNotification(EnvConfig.instance);
    await di.init();
    runApp(const MyApp());
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
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
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      builder: (context, child) {
        ScreenUtils.init(context);
        return child!;
      },
    );
  }
}