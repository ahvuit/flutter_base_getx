import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/core/auth/auth_manager.dart';

Map<String, dynamic> setupAuthHeaders(String? token) {
  Map<String, dynamic> headers = {};
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final AuthManager auth;
  final Dio dio;
  final Future Function()? refreshToken;

  AuthInterceptor(this.auth, this.dio, this.refreshToken);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll(await _setupTokenHeaders());
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (refreshToken != null && _isUnauthorized(err)) {
      final requestOptions = err.requestOptions;
      try {
        log('Refreshing token for ${requestOptions.path}');
        await refreshToken!();
        final newHeaders = await _setupTokenHeaders();
        requestOptions.headers.addAll(newHeaders);

        log('Retrying request ${requestOptions.path}');
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        log('Token refresh or retry failed: ${e.toString()}');
        return handler.next(_create401Error(requestOptions, e));
      }
    }
    return handler.next(err);
  }

  Future<Map<String, dynamic>> _setupTokenHeaders() async {
    final token = await auth.getToken();
    return setupAuthHeaders(token);
  }

  bool _isUnauthorized(DioException err) =>
      err.response?.statusCode == 401 ||
      err.error?.toString().toLowerCase().contains('unauthorized') == true;

  DioException _create401Error(RequestOptions options, Object error) =>
      DioException(
        requestOptions: options,
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 401,
          data: {'error': 'Unauthorized'},
          requestOptions: options,
        ),
        error: error,
      );
}
