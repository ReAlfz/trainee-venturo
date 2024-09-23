import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPageController extends GetxController {
  static AllPageController get to => Get.find();

  RxInt page = 0.obs;
  PageController pageController = PageController();

  void changePage(int index) {
    page.value = index;
    pageController.jumpToPage(index);
  }
}