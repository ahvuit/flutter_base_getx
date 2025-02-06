import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/logger/logger_service.dart';
import 'package:flutter_base_getx/app/core/network/dio_config.dart';
import 'package:flutter_base_getx/app/core/network/network_info.dart';
import 'package:flutter_base_getx/app/core/network/rate_limiter.dart';
import 'package:flutter_base_getx/app/core/storage/secure_storage_service.dart';
import 'package:flutter_base_getx/app/core/storage/shared_preferences_service.dart';
import 'package:flutter_base_getx/app/core/storage/storage_service.dart';
import 'package:flutter_base_getx/app/data/datasources/remote/example_remote_datasource.dart';
import 'package:flutter_base_getx/app/data/repositories/example_repository_impl.dart';
import 'package:flutter_base_getx/app/data/service/example_api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Logger
  sl.registerLazySingleton(() => LoggerService());

  // Repository
  sl.registerLazySingleton<ExampleRepository>(() => ExampleRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<ExampleRemoteDataSource>(() => ExampleRemoteDataSourceImpl(sl()));

  // Storage services
  sl.registerLazySingleton<StorageService>(() => SharedPreferencesService(sl()));
  sl.registerLazySingleton<StorageService>(() => SecureStorageService(sl()), instanceName: 'secure');
  sl.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());

  // Rate Limiter
  sl.registerLazySingleton(() => RateLimiter(maxRequests: 10, window: const Duration(minutes: 1)));

  // Dio
  sl.registerLazySingleton(() => DioConfig.createDio());

  // API service
  sl.registerLazySingleton(() => ExampleApiService(sl()));

  // Global Navigator Key
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  // Await SharedPreferences init
  await sl.allReady();
}