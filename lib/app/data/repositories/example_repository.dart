import 'package:dartz/dartz.dart';
import 'package:flutter_base_getx/app/data/datasources/remote/example_remote_datasource.dart';
import 'package:flutter_base_getx/app/data/models/base/base_response.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:injectable/injectable.dart';

abstract class ExampleRepository {
  Future<Either<String, BaseResponse<ExampleModel>>> getExample(int id);
  Future<Either<String, BaseResponse<List<ExampleModel>>>> getExampleList(
    int page,
    int limit,
  );
}

@Injectable(as: ExampleRepository)
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;
  ExampleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, BaseResponse<ExampleModel>>> getExample(int id) {
    return remoteDataSource.getExample(id);
  }

  @override
  Future<Either<String, BaseResponse<List<ExampleModel>>>> getExampleList(
    int page,
    int limit,
  ) {
    return remoteDataSource.getExampleList(page, limit);
  }
}
