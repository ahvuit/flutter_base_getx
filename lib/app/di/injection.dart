import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_config.dart';
import 'package:flutter_base_getx/app/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @singleton
  Dio provideDio(DioConfig dioConfig) => dioConfig.dio;

  @singleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}
