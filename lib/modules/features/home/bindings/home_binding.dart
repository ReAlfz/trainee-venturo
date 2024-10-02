import 'package:get/get.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

import '../../food/list_food/bindings/list_food_binding.dart';
import '../../profile/bindings/profile_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    ListFoodBindings().dependencies();
    ProfileBinding().dependencies();
  }
}