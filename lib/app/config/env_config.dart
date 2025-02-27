import 'package:flutter_base_getx/app/config/dev_config.dart';
import 'package:flutter_base_getx/app/config/prod_config.dart';
import 'package:firebase_core/firebase_core.dart';

enum Flavor {
  dev,
  prod,
}

class EnvConfig {
  final Flavor flavor;
  final String apiBaseUrl;
  final String appName;
  final FirebaseConfig firebaseConfig;

  EnvConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.appName,
    required this.firebaseConfig,
  });

  static late EnvConfig instance;

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        instance = DevConfig();
        break;
      case Flavor.prod:
        instance = ProdConfig();
        break;
    }
  }
}

class FirebaseConfig {
  final FirebaseOptions android;
  final FirebaseOptions ios;
  FirebaseConfig({
    required this.android,
    required this.ios,
  });
}

