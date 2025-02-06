import 'package:dartz/dartz.dart';
import 'package:flutter_base_getx/app/core/error/core_error_handler.dart';
import 'package:flutter_base_getx/app/data/models/base/base_response.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:flutter_base_getx/app/data/service/example_api_service.dart';
import 'package:injectable/injectable.dart';

abstract class ExampleRemoteDataSource {
  Future<Either<String, BaseResponse<ExampleModel>>> getExample(int id);
  Future<Either<String, BaseResponse<List<ExampleModel>>>> getExampleList(
    int page,
    int limit,
  );
}

@Injectable(as: ExampleRemoteDataSource)
class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final ExampleApiService apiService;

  ExampleRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<String, BaseResponse<ExampleModel>>> getExample(int id) {
    return CoreErrorHandler.wrapInEither(() async {
      return await apiService.getExample(id);
    });
  }

  @override
  Future<Either<String, BaseResponse<List<ExampleModel>>>> getExampleList(
    int page,
    int limit,
  ) {
    return CoreErrorHandler.wrapInEither(() async {
      return await apiService.getExampleList(page, limit);
    });
  }
}
