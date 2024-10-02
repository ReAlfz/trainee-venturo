import 'package:get/get.dart';

import '../controller/list_food_controller.dart';

class ListFoodBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ListFoodController());
  }
}