import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/shared/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/session_services.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    Timer(
        const Duration(seconds: 2), () async {
      bool checkAuth = await checkSession();
      if (checkAuth) {
        Get.offAllNamed(MainRoute.list);
      } else {
        Get.offAllNamed(MainRoute.signIn);
      }
    });
    super.onInit();
  }

  // check if user still login or not (Session) //

  Future<bool> checkSession() async {
    SessionService sessionService = SessionService();
    String? token = await sessionService.getToken();
    if (token != null) {
      GlobalController.to.session.value = token;
      return true;
    }

    return false;
  }
}
