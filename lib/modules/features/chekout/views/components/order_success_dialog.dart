import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          15.verticalSpace,
          SvgPicture.asset(
            ImageConstant.ic_order_success,
          ),

          30.verticalSpace,
          Text(
            'Order is being prepared'.tr,
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 27.sp,
            ),
            textAlign: TextAlign.center,
          ),

          5.verticalSpace,
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(children: [
              TextSpan(
                text: 'You can track your order in'.tr,
                style: Get.textTheme.headlineSmall!.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              TextSpan(
                text: ' Order'.tr,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                ),
              ),
            ]),
          ),

          20.verticalSpace,

          SizedBox(
            width: 168.w,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButtonStyle.mainRounded(
                bg_color: MainColor.primary,
                height: 40.h,
                width: 100.w,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Okay',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 14.sp
                    ),
                  ),
                ],
              ),
            ),
          ),

          5.verticalSpace,
        ],
      ),
    );
  }
}