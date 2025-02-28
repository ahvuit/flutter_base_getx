import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Implement proper certificate validation here
        // For example, you can check the certificate's issuer or fingerprint
        // Return true if the certificate is trusted, otherwise return false
        return _isCertificateTrusted(cert);
      };
  }

  bool _isCertificateTrusted(X509Certificate cert) {
    // Add your certificate validation logic here
    // For example, check the certificate's issuer or fingerprint
    // Return true if the certificate is trusted, otherwise return false
    return true; // Replace with actual validation logic
  }
}
