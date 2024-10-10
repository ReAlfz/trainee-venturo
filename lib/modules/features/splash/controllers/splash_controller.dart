import 'dart:async';

import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/sign_in/modules/user_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/hive_services.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    Timer(
        const Duration(seconds: 2), () async {

      bool checkAuth = await checkSession();
      if (checkAuth) {
        Get.offAllNamed(MainRoute.location);
      } else {
        Get.offAllNamed(MainRoute.signIn);
      }
    });
    super.onInit();
  }

  // check if user still login or not (Session) //

  Future<bool> checkSession() async {
    String? token = LocalStorageService.getToken();
    UserModel? user = LocalStorageService.getUser();
    if (token != null && user != null) {
      GlobalController.to.session.value = token;
      GlobalController.to.user.value = user;
      return true;
    }

    return false;
  }
}
