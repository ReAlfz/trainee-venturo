import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}