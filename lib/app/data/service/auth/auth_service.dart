import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/data/models/auth/check_update.dart';
import 'package:flutter_base_getx/app/data/models/auth/check_update_request.dart';
import 'package:flutter_base_getx/app/data/models/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
@singleton
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST('/public/checkUpdate')
  Future<BaseResponse<CheckUpdate>> checkUpdate(
    @Body() CheckUpdateRequest request,
  );
}
