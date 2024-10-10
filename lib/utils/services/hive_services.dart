import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trainee/modules/features/sign_in/modules/user_model.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final tokenBox = Hive.box('token');
  static final user = Hive.box<UserModel>('user');

  static saveToken(String token) {
    tokenBox.put('token', token);
  }

  static String? getToken() {
    return tokenBox.get('token', defaultValue: null);
  }

  static saveUser(UserModel userModel) {
    user.put('user', userModel);
  }

  static UserModel? getUser() {
    return user.get('user', defaultValue: null);
  }

  static logout() {
    user.clear();
    tokenBox.clear();
  }
}