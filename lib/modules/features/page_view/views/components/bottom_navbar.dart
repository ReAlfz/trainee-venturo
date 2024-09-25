import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/page_view/controllers/all_page_controller.dart';

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
              onTap: () => AllPageController.to.changePage(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () => AllPageController.to.changePage(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bakery_dining_rounded,
                    color: Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Pesanan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () => AllPageController.to.changePage(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fact_check_outlined,
                    color: Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () => AllPageController.to.changePage(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey[100],
                  ),

                  2.verticalSpace,

                  Text(
                    'Beranda',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[100],
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