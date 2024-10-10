import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxInt currentIndex = 0.obs;
  final foodKey = Get.nestedKey(1);
  final orderKey = Get.nestedKey(2);

  void changePage(int index) {
    currentIndex(index);
  }

  void pushCheckout() => Get.toNamed(MainRoute.checkout);
}