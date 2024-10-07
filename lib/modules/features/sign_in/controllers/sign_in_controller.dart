import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/sign_in/repositories/sign_repository.dart';
import 'package:trainee/modules/features/sign_in/views/components/flavor_setting.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var emailValue = "".obs;

  var passwordCtrl = TextEditingController();
  var passwordValue = "".obs;

  var isPassword = true.obs;
  var isRememberMe = false.obs;
  late final SignRepository repository;

  void showPassword() => isPassword.value = !isPassword.value;
  void forgetPasswordPush() => Get.toNamed(MainRoute.forgotPassword);
  void signWithGoogle() async => await repository.requestWithGoogle();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    repository = SignRepository();
    super.onInit();
  }

  // validate textfield with form //
  void validateForm(context) async {
    await GlobalController.to.checkConnection(MainRoute.signIn);

    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang Diproses...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );

      formKey.currentState!.save();
      bool checkAuth = await repository.requestAuth(
        email: emailCtrl.text, password: passwordCtrl.text,
      );

      if (checkAuth) {
        EasyLoading.dismiss();
        Get.offAllNamed(MainRoute.location);
      } else {
        EasyLoading.dismiss();
        PanaraInfoDialog.show(
          context,
          title: "Warning",
          message: "Email & Password Salah",
          buttonText: "Coba lagi",
          onTapDismiss: () {
            Get.back();
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false,
        );
      }
    }
  }

  // change api //
  void flavorSetting() async {
    Get.bottomSheet(const FlavorSettings());
  }
}
