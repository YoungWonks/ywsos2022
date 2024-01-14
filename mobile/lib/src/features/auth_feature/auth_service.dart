import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect.dart';
import 'package:mobile/src/core/constants.dart';

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
      await secureStorage.write(
          key: 'access_token', value: extractedData['access_token']);
      await secureStorage.write(
          key: 'refresh_token', value: extractedData['refresh_token']);
    } catch (e) {
      log("Error: ${e.toString()}");
    }
  }

  Future<void> registerUser(String username, String password) async {
    final response = await post(
        'http://127.0.0.1:8000/api/auth/register',
        contentType: 'application/json',
        jsonEncode({
          "username": username,
          "password": password,
        }));
    if (response.statusCode != 200) {
      throw response.statusText.toString();
    }
  }

  Future<bool> verifyAccessToken() async {
    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) return false;
      final response = await get(
        'http://127.0.0.1:8000/api/auth/access-token',
        headers: {
          "authorization": accessToken,
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

  void refreshAccessToken() async {
    try {
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      final response =
          await get('http://127.0.0.1:8000/api/auth/refresh-token', headers: {
        "authorization": "$refreshToken",
      });
      if (response.statusCode != 200) {
        throw response.statusText.toString();
      }
      final decodedResponse = json.decode(response.body);
      await secureStorage.write(
          key: 'access_token', value: decodedResponse['access_token']);
    } catch (e) {
      log(e.toString());
    }
  }
}
