import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/src/features/auth_feature/auth_service.dart';

class AuthController extends GetxController with StateMixin {
  final authService = AuthService();

  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void loginUser(String username, String password) async {
    change(null, status: RxStatus.loading());
    authService.loginUser(username, password);
    change(null, status: RxStatus.success());
    final isAccessTokenVerified = await authService.verifyAccessToken();
  }

  @override
  void onInit() {
    final box = GetStorage();
    final isAccessTokenVerified = authService.verifyAccessToken();
    super.onInit();
  }

  @override
  void onClose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
