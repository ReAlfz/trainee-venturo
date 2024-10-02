import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

import '../../food/list_food/views/ui/list_food_view.dart';
import '../../order/list_order/views/ui/order_view.dart';
import '../../profile/views/ui/profile_view.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  List<Widget> bodyWidgetOption = [
    const ListFoodView(),
    const OrderView(),
    const ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void pushCheckout() {
    Get.toNamed(MainRoute.checkout);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}