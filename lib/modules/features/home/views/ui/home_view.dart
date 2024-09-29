import 'package:flutter/material.dart';
import 'package:trainee/modules/features/home/views/components/bottom_navbar.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: HomeController.to.pageController,
              onPageChanged: HomeController.to.changePage,
              children: HomeController.to.bodyWidgetOption,
            ),
          ),

          const BottomNavBar(),
        ],
      ),
    );
  }
}