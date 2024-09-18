import 'package:get/get.dart';
import 'package:trainee/shared/global_controller.dart';

class GlobalBindding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}