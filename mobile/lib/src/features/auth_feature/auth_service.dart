import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetConnect {
  Future<void> loginUser(String username, String password) async {
    final response = await post(
        'http://10.0.2.2:8000/api/auth/login',
        contentType: 'application/json',
        jsonEncode({
          "username": username,
          "password": password,
        }));
    if (response.statusCode != 200) {
      print(response.statusText);
      return;
    }
    final extractedData = Map<String, dynamic>.from(response.body);
    final box = GetStorage();
    box.write('access_token', extractedData['access_token']);
    box.write('refresh_token', extractedData['refresh_token']);
  }
}
