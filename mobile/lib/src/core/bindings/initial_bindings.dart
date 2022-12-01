import 'package:get/get.dart';
import 'package:mobile/src/features/auth_feature/auth_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
