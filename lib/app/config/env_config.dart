import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base_getx/app/config/dev_config.dart';
import 'package:flutter_base_getx/app/config/prod_config.dart';

enum Flavor { dev, prod }

abstract class EnvConfig {
  final Flavor flavor;
  final String apiBaseUrl;
  final String appName;
  final FirebaseOptions firebaseOptions;
  final List<String> sslFingerprints;
  final List<String> excludedRateLimitEndpoints;

  EnvConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.appName,
    required this.firebaseOptions,
    required this.sslFingerprints,
    required this.excludedRateLimitEndpoints,
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
