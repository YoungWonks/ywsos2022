import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class LoginView extends HookWidget {
  LoginView({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final usernameTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
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
                'Sign In',
                style: Theme.of(context).textTheme.headline1,
              ),
              Column(
                children: [
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
                  Row(
                    children: [
                      Text(
                        "Remember me",
                        style: Theme.of(context).textTheme.bodyText1,
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
                    'New here? Let\'s get you started.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("Click here to register"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
