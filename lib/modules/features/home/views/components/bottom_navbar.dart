import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';
import 'package:trainee/modules/features/home/views/components/item_navbar.dart';
import 'package:trainee/modules/features/order/list_order/controllers/order_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 55.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.r),
              ),
              color: MainColor.black,
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ItemNavbar(
                    onTap: () => HomeController.to.changePage(0),
                    svgIcon: SvgPicture.asset(
                      ImageConstant.ic_home_bottom_navbar,
                      width: 20.w,
                      fit: BoxFit.fitWidth,
                      color: (HomeController.to.currentIndex.value == 0)
                          ? MainColor.white
                          : Colors.grey[400],
                    ),
                    title: 'Beranda',
                    checkIndex: 0,
                  ),
                  ItemNavbar(
                    onTap: () => HomeController.to.changePage(1),
                    svgIcon: SvgPicture.asset(
                      ImageConstant.ic_order_bottom_navbar,
                      width: 30.w,
                      fit: BoxFit.fitWidth,
                      color: (HomeController.to.currentIndex.value == 1)
                          ? MainColor.white
                          : Colors.grey[400],
                    ),
                    title: 'Pesanan',
                    checkIndex: 1,
                  ),
                  ItemNavbar(
                    onTap: () => HomeController.to.changePage(2),
                    svgIcon: SvgPicture.asset(
                      ImageConstant.ic_profile_bottom_navbar,
                      width: 25.w,
                      fit: BoxFit.fitWidth,
                      color: (HomeController.to.currentIndex.value == 2)
                          ? MainColor.white
                          : Colors.grey[400],
                    ),
                    title: 'Profile',
                    checkIndex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          return (orderController.orderIndicator != 0)
              ? Padding(
                  padding: EdgeInsets.only(left: 65.w),
                  child: Transform.translate(
                    offset: const Offset(0, -10),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 26.5.r,
                        width: 26.5.r,
                        padding: EdgeInsets.all(2.5.r),
                        decoration: BoxDecoration(
                          color: MainColor.primary,
                          border: Border.all(color: MainColor.white),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          orderController.orderIndicator.toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: 16,
                            color: MainColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        }),
      ],
    );
  }
}
