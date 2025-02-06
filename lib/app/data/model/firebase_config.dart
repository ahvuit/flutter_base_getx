import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  final FirebaseOptions android;
  final FirebaseOptions ios;
  FirebaseConfig({
    required this.android,
    required this.ios,
  });
}
