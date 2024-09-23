import 'package:get/get.dart';
import 'package:trainee/modules/features/page_view/controllers/all_page_controller.dart';

class AllPageBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllPageController());
  }
}