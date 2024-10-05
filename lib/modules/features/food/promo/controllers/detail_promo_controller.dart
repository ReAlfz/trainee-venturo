import 'package:get/get.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

class DetailPromoController extends GetxController {
  static DetailPromoController get to => Get.find();

  void backPromo() => Get.back(id: HomeController.to.navigatorFoodId);
}