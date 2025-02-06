import 'package:flutter_base_getx/app/config/flavor_config.dart';

class ProdConfig implements FlavorConfig {
  @override
  Flavor get flavor => Flavor.prod;

  @override
  String get apiBaseUrl => "https://api.example.com/";

  @override
  String get appName => "Example App";

  @override
  // TODO: implement firebaseConfig
  FirebaseConfig get firebaseConfig => throw UnimplementedError();
}