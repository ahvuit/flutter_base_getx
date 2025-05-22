class CoreConstants {
  static const Duration apiTimeout = Duration(seconds: 10);
  static const int maxApiRetries = 3;
  static const dynamic successCode = 200;

  ///Refresh token end point
  static String refreshTokenEndPoint = 'access/refresh-token';

  ///Params for refresh token API
  static String accessTokenParamKey = 'accessToken';
  static String refreshTokenParamKey = 'refreshToken';
  static String deviceTokenParamKey = 'deviceToken';

  ///Access token key in API header
  static const String accessTokenHeaderKey = 'Authorization';
  static const String accessFCMToken = 'FCMToken';
  static const String clientIdHeaderKey = 'ClientId';
  static const String clientKeyHeaderKey = 'ClientKey';
  static const String acceptLanguageHeaderKey = 'Accept-Language';
  static const String acceptVersionHeaderKey = 'Accepts-Version';
  static const String acceptAppVersionHeaderKey = 'Accepts-App-Version';
  static const String acceptPlatformHeaderKey = 'Accepts-Platform';
  static const String acceptDatetimeHeaderKey = 'Accept-Datetime';
}