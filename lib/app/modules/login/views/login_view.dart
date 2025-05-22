import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/base/base_screen.dart';
import '../controllers/login_controller.dart';

class LoginView extends BaseScreen<LoginController> {
  const LoginView({super.key});

  @override
  Widget buildMobile(BuildContext context) {
    throw UnimplementedError();
  }
}
