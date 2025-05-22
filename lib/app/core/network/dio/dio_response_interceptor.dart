import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_getx/app/core/error/core_error_code.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_error_interceptor.dart';
import 'package:flutter_base_getx/app/data/models/base/base_response.dart';
import 'package:flutter_base_getx/app/di/injection.dart';

class DioResponseInterceptor extends InterceptorsWrapper {
  final CoreLogger _logger = getIt<CoreLogger>();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final baseResponse = BaseResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
      _logger.i('${response.statusCode}: ${response.requestOptions.uri}');
      _logger.i(response.data);

      // Usecase: Respone code with SYS0009, ACC3001
      // Will same with case 401 for US change username
      // -> Handel Unauthor -> Force to logout
      if (baseResponse.code == CoreErrorCode.errorCodeSYS0009 ||
          baseResponse.code == CoreErrorCode.errorCodeACC3001) {
        handler.reject(
          UnauthorizedException(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
            ),
          ),
        );
        return;
      }
    } catch (e) {
      _logger.i(e);
    }

    super.onResponse(response, handler);
  }
}

class DioLogResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logDebug(
      'statusCode: ${response.statusCode},\n${_prettyJsonEncode(response.data)}',
    );
    logDebug('....................................................\n\n\n\n');
    super.onResponse(response, handler);
  }

  void logDebug(String message) {
    final now = DateTime.now();
    final timeString =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    if (kDebugMode) {
      final logMessage =
          '👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉\n[DEBUG][$timeString] \n$message';
      log(logMessage);
    }
  }

  String _prettyJsonEncode(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);
      return jsonString;
    } catch (e) {
      return data.toString();
    }
  }
}
