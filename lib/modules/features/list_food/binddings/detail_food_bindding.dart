import 'package:get/get.dart';
import 'package:trainee/modules/features/list_food/controllers/detail_food_controller.dart';

class DetailFoodBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailFoodController());
  }
}