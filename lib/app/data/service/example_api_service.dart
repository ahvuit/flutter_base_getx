import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'example_api_service.g.dart';

@RestApi()
@injectable
abstract class ExampleApiService {
  @factoryMethod
  factory ExampleApiService(Dio dio, {String? baseUrl}) = _ExampleApiService;

  @GET('/example/{id}')
  Future<ExampleModel> getExample(@Path('id') int id);

  @GET('/examples')
  Future<List<ExampleModel>> getExampleList(
    @Query('page') int page,
    @Query('limit') int limit,
  );
}
