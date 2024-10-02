import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../configs/themes/main_color.dart';
import '../../../../../../shared/styles/google_text_style.dart';
import '../../controllers/detail_food_controller.dart';

class CatatanBottomSheet extends StatelessWidget {
  const CatatanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MainColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 5.h,
              width: 100.w,
              margin: EdgeInsets.only(top: 7.5.h),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(30.r)),
            ),
          ),
          15.verticalSpace,
          Text(
            'Buat Catatan',
            style: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.1,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 58.h,
                  ),
                  child: TextFormField(
                    maxLength: 100,
                    controller: DetailFoodController.to.textController,
                    style: GoogleTextStyle.fw400.copyWith(
                      fontSize: 15.sp,
                      color: MainColor.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'tambahkan catatan',
                      hintStyle: GoogleTextStyle.fw400.copyWith(
                        fontSize: 14.sp,
                        color: MainColor.grey,
                      ),
                      contentPadding: EdgeInsets.only(bottom: 0.h),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: MainColor.grey),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: MainColor.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: MainColor.primary),
                      ),
                    ),
                  ),
                ),
              ),
              15.horizontalSpace,
              InkWell(
                onTap: () {
                  Get.back(result: DetailFoodController.to.textController.text);
                },
                child: Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: const BoxDecoration(
                    color: MainColor.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: MainColor.white,
                    size: 22.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
