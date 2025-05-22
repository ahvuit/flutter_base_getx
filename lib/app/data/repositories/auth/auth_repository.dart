import 'package:dartz/dartz.dart';
import 'package:flutter_base_getx/app/core/constants/core_constants.dart';
import 'package:flutter_base_getx/app/core/error/core_error_handler.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_config.dart';
import 'package:flutter_base_getx/app/data/models/auth/check_update.dart';
import 'package:flutter_base_getx/app/data/models/auth/check_update_request.dart';
import 'package:flutter_base_getx/app/data/models/base/base_response.dart';
import 'package:flutter_base_getx/app/data/service/auth/auth_service.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<Either<String, BaseResponse<CheckUpdate>>> checkUpdate(
    CheckUpdateRequest request,
  );
}

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService apiService;
  final DioConfig dioConfig;
  AuthRepositoryImpl(this.apiService, this.dioConfig);

  @override
  Future<Either<String, BaseResponse<CheckUpdate>>> checkUpdate(
    CheckUpdateRequest request,
  ) async {
    dioConfig.setUpHeader({CoreConstants.clientIdHeaderKey: "OMS"});
    dioConfig.setUpHeader({CoreConstants.clientKeyHeaderKey: "OMS@2024"});
    return CoreErrorHandler.wrapInEither(() async {
      return await apiService.checkUpdate(request);
    });
  }
}
