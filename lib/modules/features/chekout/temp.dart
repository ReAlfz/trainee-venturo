import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/chekout/fingerprint_dialog.dart';
import 'package:trainee/modules/features/chekout/order_success_dialog.dart';
import 'package:trainee/modules/features/chekout/pin_dialog.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

Future<void> verify() async {
  final LocalAuthentication localAuth = LocalAuthentication();
  final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
  final bool isBiometricSupport = await localAuth.isDeviceSupported();

  if (canCheckBiometrics && isBiometricSupport) {
    final String? authType = await showFingerprintDialog();

    if (authType == 'fingerprint') {
      final bool authenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to confirm order'.tr,
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        showOrderSuccessDialog();
      }

    } else if (authType == 'pin') {
      await showPinDialog();
    }
  } else {
    await showPinDialog();
  }
}

Future<void> showPinDialog() async {
  Get.until(ModalRoute.withName(MainRoute.order));
  final String userPin = GlobalController.to.user.value!.pin;

  final bool? authenticated = await Get.defaultDialog(
    title: '',
    titleStyle: const TextStyle(fontSize: 0),
    content: PinDialog(pin: userPin),
  );

  if (authenticated == true) {
    showOrderSuccessDialog();

  } else if (authenticated != null) {
    Get.until(ModalRoute.withName(MainRoute.order));
  }
}


// function dialog for checkout state //
Future<String?> showFingerprintDialog() async {
  Get.until(ModalRoute.withName(MainRoute.order));
  final result = await Get.defaultDialog(
    title: '',
    titleStyle: const TextStyle(fontSize: 0),
    content: const FingerprintDialog(),
  );

  return result;
}

Future<void> showOrderSuccessDialog() async {
  Get.until(ModalRoute.withName(MainRoute.order));
  await Get.defaultDialog(
    title: '',
    titleStyle: const TextStyle(fontSize: 0),
    content: const OrderSuccessDialog(),
  );

  Get.back();
}