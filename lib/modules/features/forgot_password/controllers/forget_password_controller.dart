import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get to => Get.find();

  final TextEditingController emailCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var emailValue = "".obs;

  void otpPush() {
    if (formKey.currentState!.validate()) {
      emailValue.value = emailCtrl.text;
      Get.toNamed(MainRoute.opt, arguments: emailCtrl.text);
    }
  }
}