import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainee/modules/features/sign_in/modules/user_model.dart';

class SessionService {

  // for token user //
  Future<void> saveToken(String key, String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, token);
  }

  Future<String?> getToken(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<void> clearToken(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  // for user //
  Future<void> saveUser(String key, UserModel data) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = jsonEncode(data.toJson());
    await preferences.setString(key, user);
  }

  Future<UserModel?> getUser(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userJson = preferences.getString(key);
    if (userJson != null) {
      UserModel data = UserModel.fromJson(jsonDecode(userJson));
      return data;
    }
    return null;
  }

  Future<void> clearUser(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }
}