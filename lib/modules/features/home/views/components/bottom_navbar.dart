import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
        ),
        color: MainColor.black,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => HomeController.to.changePage(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: (HomeController.to.currentIndex.value == 0)
                        ? MainColor.white : Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: (HomeController.to.currentIndex.value == 0)
                          ? MainColor.white : Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () => HomeController.to.changePage(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bakery_dining_rounded,
                    color: (HomeController.to.currentIndex.value == 1)
                        ? MainColor.white : Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Pesanan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: (HomeController.to.currentIndex.value == 1)
                          ? MainColor.white : Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () => HomeController.to.changePage(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fact_check_outlined,
                    color: (HomeController.to.currentIndex.value == 2)
                        ? MainColor.white : Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: (HomeController.to.currentIndex.value == 2)
                          ? MainColor.white : Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () => HomeController.to.changePage(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: (HomeController.to.currentIndex.value == 3)
                        ? MainColor.white : Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: (HomeController.to.currentIndex.value == 3)
                          ? MainColor.white : Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}