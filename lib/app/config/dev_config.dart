import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/firebase_options_dev.dart' as dev;

class DevConfig implements EnvConfig {
  @override
  String get version => "1.5";

  @override
  Flavor get flavor => Flavor.dev;

  @override
  String get apiBaseUrl => "https://omsuat.aws.fvs.vpbank.dev/omsMobileService1335/";

  @override
  String get appName => "Example App (Dev)";

  @override
  FirebaseOptions get firebaseOptions =>
      dev.DefaultFirebaseOptions.currentPlatform;

  @override
  List<String> get sslFingerprints => [];

  @override
  List<String> get excludedRateLimitEndpoints => [];

  @override
  bool get isCheckCertificatePinning => false;

  @override
  bool get isEnableProxy => false;
}
