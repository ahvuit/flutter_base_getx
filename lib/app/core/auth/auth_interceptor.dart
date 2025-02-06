import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/core/auth/auth_manager.dart';

// Sets up Authorization header with the given token
Map<String, dynamic> setupAuthHeaders(String? token) {
  Map<String, dynamic> headers = {};
  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

// Interceptor for handling authentication with queued requests
class AuthInterceptor extends QueuedInterceptorsWrapper {
  final AuthManager auth;
  final Dio dio;
  static const int maxRetryAttempts = 2;

  AuthInterceptor(this.auth, this.dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log('Adding token to request: ${options.path}');
    options.headers.addAll(await _setupTokenHeaders());
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_isUnauthorized(err)) {
      final requestOptions = err.requestOptions;
      int retryCount = requestOptions.extra['retryCount'] ?? 0;

      if (retryCount < maxRetryAttempts) {
        try {
          log('Refreshing token for ${requestOptions.path} (Attempt ${retryCount + 1}/$maxRetryAttempts)');
          final newToken = await _refreshToken();
          if (newToken != null) {
            await auth.saveToken(newToken);
            final newHeaders = setupAuthHeaders(newToken);
            requestOptions.headers.addAll(newHeaders);
            requestOptions.extra['retryCount'] = retryCount + 1;

            log('Retrying request ${requestOptions.path} with new token');
            final response = await dio.fetch(requestOptions);
            return handler.resolve(response);
          } else {
            log('Refresh token returned null, logging out');
            await _handleLogout();
            return handler.reject(_create401Error(requestOptions, 'Refresh token failed'));
          }
        } catch (e) {
          log('Token refresh or retry failed: ${e.toString()}');
          return handler.next(_create401Error(requestOptions, e));
        }
      } else {
        log('Max retry attempts ($maxRetryAttempts) reached, logging out');
        await _handleLogout();
        return handler.reject(_create401Error(requestOptions, 'Max retries exceeded'));
      }
    }
    return handler.next(err);
  }

  Future<Map<String, dynamic>> _setupTokenHeaders() async {
    final token = await auth.getToken();
    return setupAuthHeaders(token);
  }

  Future<String?> _refreshToken() async {
    final currentRefreshToken = auth.getRefreshToken();
    if (currentRefreshToken.isEmpty) return null;

    try {
      final response = await dio.post(
        '${dio.options.baseUrl}/refresh-token',
        data: {'refreshToken': currentRefreshToken},
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'] as String;
        final newRefreshToken = response.data['refreshToken'] as String;
        auth.saveRefreshToken(newRefreshToken);
        return newAccessToken;
      }
      return null;
    } catch (e) {
      log('Internal refresh token failed: $e');
      return null;
    }
  }

  bool _isUnauthorized(DioException err) =>
      err.response?.statusCode == 401 ||
          err.error?.toString().toLowerCase().contains('unauthorized') == true;

  DioException _create401Error(RequestOptions options, Object error) => DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      statusCode: 401,
      data: {'error': 'Unauthorized'},
      requestOptions: options,
    ),
    error: error,
  );

  Future<void> _handleLogout() async {
    auth.logOut();
    log('User logged out due to repeated auth failures');
    // TODO: Navigate to login screen using navigatorKey from DI
  }
}