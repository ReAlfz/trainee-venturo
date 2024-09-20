import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _tokenKey = 'session';

  Future<void> saveToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }
}