import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/src/features/auth_feature/auth_service.dart';
import 'package:mobile/src/features/auth_feature/login_view.dart';
import 'package:mobile/src/features/home_feature/home_view.dart';

class AuthController extends GetxController with StateMixin {
  final authService = AuthService();

  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void loginUser(String username, String password) async {
    change(null, status: RxStatus.loading());
    authService.loginUser(username, password);
    change(null, status: RxStatus.success());
    try {
      change(null, status: RxStatus.loading());
      await authService.loginUser(username, password);

      final isAccessTokenVerified = await authService.verifyAccessToken();
      if (isAccessTokenVerified) {
        Get.off(() => HomeView());
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      change(e.toString(), status: RxStatus.error());
    }
  }

  void registerUser(String email, String username, String password) async {
    try {
      change(null, status: RxStatus.loading());
      await authService.registerUser(username, password);
      Get.off(() => LoginView());
      change(null, status: RxStatus.success());
    } catch (e) {
      change(e.toString(), status: RxStatus.error());
    }
  }

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
  }

  @override
  void onReady() async {
    final isAccessTokenVerified = await authService.verifyAccessToken();

    if (isAccessTokenVerified) {
      // change(null, status: RxStatus.success());
      Get.off(() => HomeView());
    } else {
      authService.refreshAccessToken();
      final isAccessTokenVerified = await authService.verifyAccessToken();

      if (isAccessTokenVerified) {
        Get.off(() => HomeView());
      }
    }
    change(null, status: RxStatus.success());
    super.onReady();
  }

  @override
  void onClose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
