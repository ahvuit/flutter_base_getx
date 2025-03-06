import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class DioConfig {
  final Dio _dio;

  DioConfig() : _dio = Dio() {
    _dio.options
      ..baseUrl = EnvConfig.instance.apiBaseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
  }

  Dio get dio => _dio;
}