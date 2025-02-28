import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/data/models/example/example_model.dart';
import 'package:flutter_base_getx/app/data/repositories/example_repository_impl.dart';
import 'package:flutter_base_getx/app/di/locator.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final ExampleRepositoryImpl _repository = sl<ExampleRepositoryImpl>();
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
