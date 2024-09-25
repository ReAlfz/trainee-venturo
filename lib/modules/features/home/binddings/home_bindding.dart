import 'package:get/get.dart';
import 'package:trainee/modules/features/home/controllers/list_controller.dart';

class HomeListBinddings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeListController());
  }
}