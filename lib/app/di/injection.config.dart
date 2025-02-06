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
import 'package:flutter_base_getx/app/core/auth/auth_manager.dart' as _i591;
import 'package:flutter_base_getx/app/core/logger/core_logger.dart' as _i762;
import 'package:flutter_base_getx/app/core/network/dio/dio_config.dart' as _i24;
import 'package:flutter_base_getx/app/core/network/network_info.dart' as _i24;
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart'
    as _i100;
import 'package:flutter_base_getx/app/core/storage/core/token_manager.dart'
    as _i274;
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
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => appModule.navigatorKey,
    );
    gh.singleton<_i762.CoreLogger>(() => _i762.CoreLogger());
    gh.singleton<_i591.AuthManager>(() => _i591.AuthManager());
    gh.singleton<_i100.GetStorageService>(() => _i100.GetStorageService());
    gh.singleton<_i274.TokenCacheManager>(() => _i274.TokenCacheManager());
    gh.singleton<_i24.DioConfig>(() => _i24.DioConfig(gh<_i591.AuthManager>()));
    gh.singleton<_i361.Dio>(() => appModule.provideDio(gh<_i24.DioConfig>()));
    gh.factory<_i699.ExampleApiService>(
      () => _i699.ExampleApiService(gh<_i361.Dio>()),
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
