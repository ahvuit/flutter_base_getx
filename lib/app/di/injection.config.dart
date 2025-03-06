// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_base_getx/app/core/logger/core_logger.dart' as _i762;
import 'package:flutter_base_getx/app/core/network/dio_config.dart' as _i260;
import 'package:flutter_base_getx/app/core/network/network_info.dart' as _i24;
import 'package:flutter_base_getx/app/core/network/rate_limiter.dart' as _i846;
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart'
    as _i100;
import 'package:flutter_base_getx/app/data/datasources/remote/example_remote_datasource.dart'
    as _i463;
import 'package:flutter_base_getx/app/data/repositories/example_repository.dart'
    as _i772;
import 'package:flutter_base_getx/app/data/service/example_api_service.dart'
    as _i699;
import 'package:flutter_base_getx/app/di/injection.dart' as _i129;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i24.NetworkInfo>(() => _i24.NetworkInfo());
    gh.factory<_i100.GetStorageService>(() => _i100.GetStorageService());
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => appModule.navigatorKey,
    );
    gh.singleton<_i361.Dio>(() => appModule.dio);
    gh.singleton<_i762.CoreLogger>(() => _i762.CoreLogger());
    gh.singleton<_i260.DioConfig>(() => _i260.DioConfig());
    gh.factory<_i699.ExampleApiService>(
      () => _i699.ExampleApiService(gh<_i361.Dio>(), baseUrl: gh<String>()),
    );
    gh.factory<_i846.RateLimiter>(
      () => _i846.RateLimiter(maxRequests: gh<int>(), window: gh<Duration>()),
    );
    gh.factory<_i463.ExampleRemoteDataSource>(
      () => _i463.ExampleRemoteDataSourceImpl(gh<_i699.ExampleApiService>()),
    );
    gh.factory<_i772.ExampleRepository>(
      () => _i772.ExampleRepositoryImpl(gh<_i463.ExampleRemoteDataSource>()),
    );
    return this;
  }
}

class _$AppModule extends _i129.AppModule {}
