import 'package:get/get.dart';
import 'package:mobile/src/features/auth_feature/auth_service.dart';

class AuthController extends GetxController {
  final authService = AuthService();

  void loginUser(String username, String password) {
    authService.loginUser(username, password);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
