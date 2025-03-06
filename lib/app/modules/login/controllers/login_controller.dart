import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:flutter_base_getx/app/data/repositories/example_repository.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final _repository = getIt<ExampleRepository>();
  final Rx<ExampleModel?> example = Rx<ExampleModel?>(null);

  Future<void> fetchExample(int id) async {
    await performAction(
      () async {
        final result = await _repository.getExample(id);
        example.value = result;
      },
      onError: (msg) => Get.snackbar('Error', msg),
      enableRetry: true,
    );
  }

  @override
  int get maxRetries => 2;
}
