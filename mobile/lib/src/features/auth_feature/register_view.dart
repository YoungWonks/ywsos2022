import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/widgets/custom_app_bar.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';
import 'package:mobile/src/features/auth_feature/login_view.dart';

import '../../core/constants.dart';
import '../../core/widgets/loading_indicator.dart';

class RegisterView extends GetView<AuthController> {
  RegisterView({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final usernameTextController = controller.usernameTextController;
    final passwordTextController = controller.passwordTextController;
    final emailTextEditingController = controller.emailTextController;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: ''),
      body: Center(
        child: SingleChildScrollView(
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
                  'Sign Up',
                  style: Get.textTheme.displayMedium,
                ),
                Column(
                  children: [
                    TextField(
                      controller: emailTextEditingController,
                      decoration: const InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: usernameTextController,
                      decoration: const InputDecoration(hintText: 'Username'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordTextController,
                      decoration: const InputDecoration(hintText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authController.loginUser(usernameTextController.text,
                            passwordTextController.text);
                        controller.obx(
                          (state) => const GetSnackBar(
                            messageText: Text(
                              "Successfully logged in",
                              style: TextStyle(color: kButtonColor),
                            ),
                            snackStyle: SnackStyle.FLOATING,
                            snackPosition: SnackPosition.BOTTOM,
                            isDismissible: true,
                            titleText: Text(
                              'Success',
                              style: TextStyle(color: kButtonColor),
                            ),
                          ),
                          onLoading: const Center(child: LoadingIndicator()),
                          onError: (state) => GetSnackBar(
                            messageText: Text(
                              "Error",
                              style: TextStyle(color: kErrorColor),
                            ),
                            snackStyle: SnackStyle.FLOATING,
                            snackPosition: SnackPosition.BOTTOM,
                            isDismissible: true,
                            titleText: Text(
                              state!,
                              style: TextStyle(color: kErrorColor),
                            ),
                          ),
                        );
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
                      'Been here before? Let\'s get you signed in.',
                      style: Get.textTheme.bodyLarge,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.off(() => LoginView());
                      },
                      child: Text(
                        "Click here to sign in",
                        style: Get.textTheme.bodyLarge,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
