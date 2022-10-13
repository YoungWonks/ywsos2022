import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/widgets/custom_app_bar.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Login'),
      body: Center(
        child: Text("Login"),
      ),
    );
  }
}
