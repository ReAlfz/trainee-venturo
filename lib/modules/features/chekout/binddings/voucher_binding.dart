import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/controllers/voucher_controller.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VoucherController());
  }
}