import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/widgets/custom_app_bar.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class LoginView extends HookWidget {
  LoginView({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final usernameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    return Scaffold(
        appBar: CustomAppBar(title: 'Login'),
        body: Column(
          children: [
            TextField(
              controller: usernameTextController,
            ),
            TextField(
              controller: passwordTextController,
            ),
            ElevatedButton(
                onPressed: () {
                  authController.loginUser(
                      usernameTextController.text, passwordTextController.text);
                },
                child: Text("Submit")),
          ],
        ));
  }
}
