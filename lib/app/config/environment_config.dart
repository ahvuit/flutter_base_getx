import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_base_getx/app/data/model/firebase_config.dart';

enum EnvironmentType { dev, prod }

class EnvironmentConfig {
  final EnvironmentType env;
  final String apiUrl;
  final String appName;
  final String uploadUrl;
  final FirebaseConfig firebaseConfig;

  EnvironmentConfig.dev()
      : env = EnvironmentType.dev,
        appName = ConfigData.appNameDev,
        apiUrl = ConfigData.apiUrlDev,
        uploadUrl = '',
        firebaseConfig = FirebaseConfig(
          android: const FirebaseOptions(
            apiKey: '',
            appId: '',
            messagingSenderId: '',
            projectId: '',
            databaseURL: '',
            storageBucket: '',
          ),
          ios: const FirebaseOptions(
            apiKey: '',
            appId: '',
            messagingSenderId: '',
            projectId: '',
            databaseURL: '',
            storageBucket: '',
            androidClientId: '',
            iosClientId: '',
            iosBundleId: '',
          ),
        );

  EnvironmentConfig.prod()
      : env = EnvironmentType.prod,
        appName = ConfigData.appNameProd,
        apiUrl = ConfigData.apiUrlProd,
        uploadUrl = '',
        firebaseConfig = FirebaseConfig(
          android: const FirebaseOptions(
            apiKey: '',
            appId: '',
            messagingSenderId: '',
            projectId: '',
            databaseURL: '',
            storageBucket: '',
          ),
          ios: const FirebaseOptions(
            apiKey: '',
            appId: '',
            messagingSenderId: '',
            projectId: '',
            databaseURL: '',
            storageBucket: '',
            androidClientId: '',
            iosClientId: '',
            iosBundleId: '',
          ),
        );
}

class ConfigData {
  //PRODUCTION
  static const appNameProd = 'https://ais-uat.fecredit.cloud/';
  static const apiUrlProd = 'https://dummyjson.com';

  //DEV
  static const appNameDev = 'https://ais-uat.fecredit.cloud/';
  static const apiUrlDev= 'https://dummyjson.com';
}
