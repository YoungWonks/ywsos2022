import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Login"),
      ),
    );
  }
}
