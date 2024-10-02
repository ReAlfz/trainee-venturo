import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/food/detail_food/controllers/detail_food_controller.dart';

import '../../../../../../configs/themes/main_color.dart';
import 'menu_option.dart';

class LevelBottomSheet extends StatelessWidget {
  const LevelBottomSheet({super.key});

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
            'Pilih Level',
            style: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.1,
              fontSize: 20,
            ),
          ),

          15.verticalSpace,
          SizedBox(
            height: 30.h,
            child: ListView.separated(
              itemCount: DetailFoodController.to.catalogData.value!.level.length,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => 15.horizontalSpace,
              itemBuilder: (context, index) {
                final data = DetailFoodController.to.catalogData.value!.level[index];
                return MenuOptions(
                  width: 30.w,
                  text: data.keterangan,
                  onTap: () {
                    DetailFoodController.to.currentLevel.value = data.keterangan;
                    Get.back(result: data.keterangan);
                  },
                  isSelected: DetailFoodController.to.currentLevel.value == data.keterangan,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
