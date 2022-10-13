import 'package:get/get.dart';
import 'package:mobile/src/core/settings/themes/themes_controller.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
