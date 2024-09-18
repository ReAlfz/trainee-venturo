import 'package:get/get.dart';
import 'package:trainee/modules/features/forgot_password/controllers/forget_password_controller.dart';

class ForgorPasswordBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}