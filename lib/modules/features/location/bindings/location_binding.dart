import 'package:get/get.dart';
import 'package:trainee/modules/features/location/controllers/location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController());
  }
}