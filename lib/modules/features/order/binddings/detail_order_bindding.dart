import 'package:get/get.dart';
import 'package:trainee/modules/features/order/controllers/detail_report_controller.dart';

class DetailOrderBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailOrderController());
  }
}