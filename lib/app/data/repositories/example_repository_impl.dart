import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/data/datasources/remote/example_remote_datasource.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

abstract class ExampleRepository {
  Future<ExampleModel> getExample(int id);
  Future<List<ExampleModel>> getExampleList(int page, int limit);
}

class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;
  final CoreLogger _logger = di.sl<CoreLogger>();

  ExampleRepositoryImpl(this.remoteDataSource);

  @override
  Future<ExampleModel> getExample(int id) async {
    try {
      return await remoteDataSource.getExample(id);
    } catch (e) {
      _logger.e('Error in repository while fetching example: $e');
      rethrow;
    }
  }

  @override
  Future<List<ExampleModel>> getExampleList(int page, int limit) async {
    try {
      return await remoteDataSource.getExampleList(page, limit);
    } catch (e) {
      _logger.e('Error in repository while fetching example list: $e');
      rethrow;
    }
  }
}
