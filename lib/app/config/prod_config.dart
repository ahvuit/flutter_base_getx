import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/firebase_options_dev.dart' as prod;

class ProdConfig implements EnvConfig {
  @override
  String get version => "1.1";

  @override
  Flavor get flavor => Flavor.prod;

  @override
  String get apiBaseUrl => "https://oms.vpbank.com.vn/omsGateway/omsMobileService/";

  @override
  String get appName => "Example App";

  @override
  FirebaseOptions get firebaseOptions =>
      prod.DefaultFirebaseOptions.currentPlatform;

  @override
  List<String> get sslFingerprints => [];

  @override
  List<String> get excludedRateLimitEndpoints => [];

  @override
  bool get isCheckCertificatePinning => false;

  @override
  bool get isEnableProxy => false;
}
