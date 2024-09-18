import 'package:get/get.dart';
import 'package:trainee/modules/features/forgot_password/controllers/otp_controller.dart';

class OtpBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpController());
  }
}