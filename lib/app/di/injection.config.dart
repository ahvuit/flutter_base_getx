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
import 'package:flutter_base_getx/app/core/service/language_service.dart'
    as _i474;
import 'package:flutter_base_getx/app/core/service/theme_service.dart' as _i753;
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart'
    as _i100;
import 'package:flutter_base_getx/app/core/storage/core/storage_service.dart'
    as _i885;
import 'package:flutter_base_getx/app/core/storage/core/token_manager.dart'
    as _i274;
import 'package:flutter_base_getx/app/core/storage/storage_manager.dart'
    as _i899;
import 'package:flutter_base_getx/app/core/widget/dialog/dialog_manager.dart'
    as _i837;
import 'package:flutter_base_getx/app/core/widget/dialog/loading_dialog.dart'
    as _i836;
import 'package:flutter_base_getx/app/data/repositories/auth/auth_repository.dart'
    as _i858;
import 'package:flutter_base_getx/app/data/service/auth/auth_service.dart'
    as _i935;
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
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => appModule.navigatorKey,
    );
    gh.singleton<_i762.CoreLogger>(() => _i762.CoreLogger());
    gh.singleton<_i591.AuthManager>(() => _i591.AuthManager());
    gh.singleton<_i24.NetworkInfo>(() => _i24.NetworkInfo());
    gh.singleton<_i274.TokenCacheManager>(() => _i274.TokenCacheManager());
    gh.singleton<_i899.StorageManager>(() => _i899.StorageManager());
    gh.singleton<_i753.ThemeManager>(() => _i753.ThemeManager());
    gh.singleton<_i474.LanguageService>(() => _i474.LanguageService());
    gh.singleton<_i836.LoadingDialog>(() => _i836.LoadingDialog());
    gh.singleton<_i837.DialogManager>(() => _i837.DialogManagerImpl());
    gh.singleton<_i24.DioConfig>(() => _i24.DioConfig(gh<_i591.AuthManager>()));
    gh.singleton<_i885.StorageService>(() => _i100.GetStorageService());
    gh.singleton<_i361.Dio>(() => appModule.provideDio(gh<_i24.DioConfig>()));
    gh.singleton<_i935.AuthService>(() => _i935.AuthService(gh<_i361.Dio>()));
    gh.singleton<_i858.AuthRepository>(
      () => _i858.AuthRepositoryImpl(
        gh<_i935.AuthService>(),
        gh<_i24.DioConfig>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i129.AppModule {}
