import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/src/core/constants.dart';
import 'package:mobile/src/core/widgets/custom_app_bar.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';
import 'package:mobile/src/features/auth_feature/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      extendBodyBehindAppBar: true,
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await secureStorage.delete(key: 'access-token');
              await secureStorage.delete(key: 'refresh-token');
              Get.off(() => const LoginView());
            },
            child: Text('Logout')),
      ),
    );
  }
}
