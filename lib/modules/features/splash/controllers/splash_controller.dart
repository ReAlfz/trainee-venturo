import 'dart:async';

import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    Timer(
        const Duration(seconds: 2), () {
      Get.toNamed(MainRoute.signIn);
    });
    super.onInit();
  }
}
