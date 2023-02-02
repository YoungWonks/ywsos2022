import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetConnect {
  Future<void> loginUser(String username, String password) async {
    try {
      final response = await post(
          'http://127.0.0.1:8000/api/auth/login',
          contentType: 'application/json',
          jsonEncode({
            "username": username,
            "password": password,
          }));
      if (response.statusCode != 200) {
        throw response.statusText.toString();
      }
      final extractedData = Map<String, dynamic>.from(response.body);
      final box = GetStorage();
      await box.write('access_token', extractedData['access_token']);
      await box.write('refresh_token', extractedData['refresh_token']);
    } catch (e) {
      log("Error: ${e.toString()}");
    }
  }

  Future<bool> verifyAccessToken() async {
    try {
      final box = GetStorage();
      final response = await get(
        'http://127.0.0.1:8000/api/auth/access-token',
        headers: {
          "authorization": "Bearer ${await box.read('access_token')}",
        },
      );
      if (response.statusCode != 200) {
        throw response.statusText.toString();
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
