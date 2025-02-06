import 'package:dartz/dartz.dart';
import 'package:flutter_base_getx/app/data/models/base/base_response.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:flutter_base_getx/app/data/service/example_api_service.dart';
import 'package:injectable/injectable.dart';

abstract class ExampleRemoteDataSource {
  Future<Either<Exception, BaseResponse<ExampleModel>>> getExample(int id);
  Future<List<ExampleModel>> getExampleList(int page, int limit);
}

@Injectable(as: ExampleRemoteDataSource)
class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final ExampleApiService apiService;
  ExampleRemoteDataSourceImpl(this.apiService);

  @override
  Future<ExampleModel> getExample(int id) async {
    try {
      final result = await apiService.getExample(id);
      return result;
    } catch (e) {
    }
  }

  @override
  Future<List<ExampleModel>> getExampleList(int page, int limit) async {
    try {
      final result = await apiService.getExampleList(page, limit);
      return result;
    } catch (e) {
    }
  }
}
