import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/home/binddings/home_bindding.dart';
import 'package:trainee/modules/features/home/views/components/bottom_navbar.dart';
import 'package:trainee/modules/features/home/views/components/search_app_bar.dart';
import 'package:trainee/modules/features/home/views/ui/list_item_view.dart';
import 'package:trainee/modules/features/page_view/controllers/all_page_controller.dart';

class AllPageView extends StatelessWidget {
  const AllPageView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: const SearchAppBar(),
        body: PageView(
          controller: AllPageController.to.pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            GetBuilder<AllPageController>(
              builder: (_) {
                HomeBinddings().dependencies();
                return const HomeListView();
              },
            ),
            Container(),
            Container(),
            Container(),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}