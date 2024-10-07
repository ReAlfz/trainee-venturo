import 'dart:io';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/constants/cores/api/api_constant.dart';

import '../features/sign_in/modules/user_model.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  // checkConnection //

  var isConnect = false.obs;
  var baseUrl = ApiConstant.production;
  var isStaging = false.obs;
  var session = ''.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxString jumpRoute = ''.obs;

  Future<void> checkConnection(String route) async {
    jumpRoute.value = route;
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );

      Get.offAllNamed(MainRoute.noConnection);
    }
  }
}