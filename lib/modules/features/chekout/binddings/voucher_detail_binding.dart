import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/controllers/voucher_detail_controller.dart';

class VoucherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VoucherDetailController());
  }
}