import 'package:flutter_base_getx/app/core/error/error_handler.dart';
import 'package:flutter_base_getx/app/core/logger/logger_service.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:flutter_base_getx/app/data/service/example_api_service.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

abstract class ExampleRemoteDataSource {
  Future<ExampleModel> getExample(int id);
  Future<List<ExampleModel>> getExampleList(int page, int limit);
}

class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final ExampleApiService apiService;
  final LoggerService _logger = di.sl<LoggerService>();

  ExampleRemoteDataSourceImpl(this.apiService);

  @override
  Future<ExampleModel> getExample(int id) async {
    try {
      _logger.i('Fetching example with id: $id');
      final result = await apiService.getExample(id);
      _logger.d('Successfully fetched example: ${result.id}');
      return result;
    } catch (e) {
      _logger.e('Failed to fetch example: $e');
      throw ErrorHandler.handleException(e);
    }
  }

  @override
  Future<List<ExampleModel>> getExampleList(int page, int limit) async {
    try {
      _logger.i('Fetching example list - page: $page, limit: $limit');
      final result = await apiService.getExampleList(page, limit);
      _logger.d('Successfully fetched ${result.length} examples');
      return result;
    } catch (e) {
      _logger.e('Failed to fetch example list: $e');
      throw ErrorHandler.handleException(e);
    }
  }
}