import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../constants/cores/api/api_constant.dart';
import '../../../../../shared/styles/google_text_style.dart';
import '../../../../global_controllers/global_controller.dart';

class FlavorSettings extends StatelessWidget {
  const FlavorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: [
          Container(
            width: double.infinity.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: MainColor.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 5.h,
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    GlobalController.to.isStaging.value = false;
                    GlobalController.to.baseUrl = ApiConstant.production;
                  },
                  title: Text(
                    'Production',
                    style: GoogleTextStyle.fw400.copyWith(
                      color: GlobalController.to.isStaging.value == true
                          ? MainColor.black
                          : MainColor.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: (GlobalController.to.isStaging.value == true)
                      ? null
                      : Icon(
                          Icons.check,
                          color: MainColor.primary,
                          size: 14.sp,
                        ),
                ),
                Divider(height: 1.h),
                ListTile(
                  onTap: () {
                    GlobalController.to.isStaging.value = true;
                    GlobalController.to.baseUrl = ApiConstant.staging;
                  },
                  title: Text(
                    'Stagging',
                    style: GoogleTextStyle.fw400.copyWith(
                      color: GlobalController.to.isStaging.value == true
                          ? MainColor.black
                          : MainColor.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: (!GlobalController.to.isStaging.value == true)
                      ? null
                      : Icon(
                          Icons.check,
                          color: MainColor.primary,
                          size: 14.sp,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
