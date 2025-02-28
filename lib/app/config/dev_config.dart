import 'package:flutter_base_getx/app/config/env_config.dart';

class DevConfig implements EnvConfig {
  @override
  Flavor get flavor => Flavor.dev;

  @override
  String get apiBaseUrl => "https://api.dev.example.com/";

  @override
  String get appName => "Example App (Dev)";

  @override
  // TODO: implement firebaseConfig
  FirebaseConfig get firebaseConfig => throw UnimplementedError();

  @override
  // TODO: implement sslFingerprints
  String get sslFingerprints => throw UnimplementedError();
}