import 'package:flutter/material.dart';
import 'package:trainee/modules/features/page_view/views/components/bottom_navbar.dart';
import 'package:trainee/modules/features/page_view/controllers/all_page_controller.dart';

class AllPageView extends StatefulWidget {
  const AllPageView({super.key});

  @override
  State<AllPageView> createState() => _AllPageViewState();
}

class _AllPageViewState extends State<AllPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: AllPageController.to.pageController,
            onPageChanged: AllPageController.to.changePage,
            children: AllPageController.to.bodyWidgetOption,
          ),

          const Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomNavBar(),
          ),
        ],
      ),
    );
  }
}