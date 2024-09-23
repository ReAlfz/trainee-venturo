import 'package:get/get.dart';
import 'package:trainee/modules/features/checkout/controllers/checkout_controller.dart';

class CheckoutBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}