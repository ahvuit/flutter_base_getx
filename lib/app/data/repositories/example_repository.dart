import 'package:flutter_base_getx/app/data/datasources/remote/example_remote_datasource.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:injectable/injectable.dart';

abstract class ExampleRepository {
  Future<ExampleModel> getExample(int id);
  Future<List<ExampleModel>> getExampleList(int page, int limit);
}

@Injectable(as: ExampleRepository)
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;
  ExampleRepositoryImpl(this.remoteDataSource);

  @override
  Future<ExampleModel> getExample(int id) async {
    return await remoteDataSource.getExample(id);
  }

  @override
  Future<List<ExampleModel>> getExampleList(int page, int limit) async {
    return await remoteDataSource.getExampleList(page, limit);
  }
}
