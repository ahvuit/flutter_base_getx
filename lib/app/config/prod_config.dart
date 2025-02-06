import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/firebase_options_dev.dart' as prod;

class ProdConfig implements EnvConfig {
  @override
  Flavor get flavor => Flavor.prod;

  @override
  String get apiBaseUrl => "https://api.example.com/";

  @override
  String get appName => "Example App";

  @override
  FirebaseOptions get firebaseOptions =>
      prod.DefaultFirebaseOptions.currentPlatform;

  @override
  // TODO: implement sslFingerprints
  List<String> get sslFingerprints => [];

  @override
  // TODO: implement excludedRateLimitEndpoints
  List<String> get excludedRateLimitEndpoints => [];
}
