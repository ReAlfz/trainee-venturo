import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/home/views/ui/list_item_view.dart';
import 'package:trainee/modules/features/order/views/ui/order_view.dart';

class AllPageController extends GetxController {
  static AllPageController get to => Get.find();

  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  List<Widget> bodyWidgetOption = [
    const HomeListView(),
    const OrderView(),
    Container(color: Colors.blue,),
    Container(color: Colors.red,),
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