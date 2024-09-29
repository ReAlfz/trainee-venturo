import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/views/ui/checkout_view.dart';
import 'package:trainee/modules/features/list_food/views/ui/list_food_view.dart';
import 'package:trainee/modules/features/order/views/ui/order_view.dart';
import 'package:trainee/modules/features/profile/views/ui/profile_view.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  List<Widget> bodyWidgetOption = [
    const ListFoodView(),
    const OrderView(),
    const CheckoutView(),
    const ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}