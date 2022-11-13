import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class RegisterView extends HookWidget {
  RegisterView({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final usernameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    final emailTextEditingController = useTextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                'Sign Up',
                style: Theme.of(context).textTheme.headline1,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authController.loginUser(usernameTextController.text,
                          passwordTextController.text);
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Been here before? Let\'s get you signed in.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Click here to register"),
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
