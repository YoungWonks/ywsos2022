import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/widgets/custom_app_bar.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';
import 'package:mobile/src/features/auth_feature/register_view.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: ''),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.2),
            borderRadius: BorderRadius.circular(13),
          ),
          height: Get.height / 1.5,
          width: Get.width / 1.2,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sign In',
                style: Get.textTheme.displayMedium,
              ),
              Column(
                children: [
                  TextField(
                    controller: controller.usernameTextController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.passwordTextController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Remember me",
                        style: Get.textTheme.bodyLarge,
                      ),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black.withOpacity(.32);
                          }
                          return Colors.black;
                        }),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.loginUser(
                          controller.usernameTextController.text,
                          controller.passwordTextController.text);
                    },
                    child: Text(
                      "Submit",
                      style: Get.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'New here? Let\'s get you started.',
                    style: Get.textTheme.bodyLarge,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.off(() => RegisterView());
                    },
                    child: Text(
                      "Click here to register",
                      style: Get.textTheme.bodyLarge,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
