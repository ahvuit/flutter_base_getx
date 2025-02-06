import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/firebase_options_dev.dart' as dev;

class DevConfig implements EnvConfig {
  @override
  Flavor get flavor => Flavor.dev;

  @override
  String get apiBaseUrl => "https://api.dev.example.com/";

  @override
  String get appName => "Example App (Dev)";

  @override
  FirebaseOptions get firebaseOptions =>
      dev.DefaultFirebaseOptions.currentPlatform;

  @override
  // TODO: implement sslFingerprints
  List<String> get sslFingerprints => [];

  @override
  // TODO: implement excludedRateLimitEndpoints
  List<String> get excludedRateLimitEndpoints => [];
}
