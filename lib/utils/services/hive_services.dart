import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final box = Hive.box('venturo');

  static Future deleteAuth() async {
    if (box.get('isRememberMe') ==  false) {
      box.clear();
      box.put('isLogin', false);
    } else {
      box.put('isLogin', false);
    }
  }
}