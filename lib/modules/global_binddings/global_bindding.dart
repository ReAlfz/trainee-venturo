import 'package:get/get.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class GlobalBindding implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }
}