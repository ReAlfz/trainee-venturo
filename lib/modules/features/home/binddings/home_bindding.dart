import 'package:get/get.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';
import 'package:trainee/modules/features/list_food/binddings/list_food_bindding.dart';

class HomeBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    ListFoodBinddings().dependencies();
  }
}