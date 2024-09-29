import 'package:get/get.dart';
import 'package:trainee/modules/features/list_food/controllers/list_food_controller.dart';

class ListFoodBinddings extends Bindings {
  @override
  void dependencies() {
    Get.put(ListFoodController());
  }
}