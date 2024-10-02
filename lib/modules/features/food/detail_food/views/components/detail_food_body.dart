import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/shared/widgets/custom_divider.dart';

import '../../../../../../configs/themes/main_color.dart';
import '../../../../../../constants/cores/assets/image_constant.dart';
import '../../../../../../shared/widgets/quantitiy_counter.dart';
import '../../../../../../shared/widgets/tile_option.dart';
import '../../controllers/detail_food_controller.dart';
import '../../models/detail_food_model.dart';

class DetailFoodBody extends StatelessWidget {
  final DetailFoodModel food;

  const DetailFoodBody({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    var heightTileOption = 50.h;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 100.h,
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food.menu.nama,
                      style: Get.textTheme.labelLarge!
                          .copyWith(color: MainColor.primary, fontSize: 20.sp),
                    ),
                    Container(
                      height: 50.r,
                      padding: EdgeInsets.only(left: 12.r, right: 5.r),
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        child: Obx(
                          () => QuantityCounter(
                            quantity: DetailFoodController.to.quantity.value,
                            onIncrement: DetailFoodController.to.onIncrease,
                            onDecrement: DetailFoodController.to.onDecrease,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              5.verticalSpacingRadius,
              Expanded(
                child: Text(
                  food.menu.deskripsi,
                  style: Get.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        15.verticalSpace,
        const CustomDivider(thickness: 0.2),
        Container(
          height: heightTileOption,
          margin: EdgeInsets.symmetric(vertical: 1.5.h),
          child: TileOption(
            title: 'Harga'.tr,
            svgPicture: ImageConstant.ic_harga,
            titleStyle: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            message: 'Rp ${food.menu.harga}',
            messageStyle: Get.textTheme.titleMedium!.copyWith(
              color: MainColor.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const CustomDivider(thickness: 0.2),
        Container(
          height: heightTileOption,
          margin: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Obx(
            () => TileOption(
              title: 'Level'.tr,
              svgPicture: ImageConstant.ic_level,
              titleStyle: Get.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              message: DetailFoodController.to.currentLevel.value,
              messageStyle: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 15,
              ),
              onTap: (food.level.isNotEmpty)
                  ? () => DetailFoodController.to.selectOption('level')
                  : null,
            ),
          ),
        ),
        const CustomDivider(thickness: 0.2),
        Container(
          height: heightTileOption,
          margin: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Obx(() {
            final getList = DetailFoodController.to.currentTopping
                .map((element) => element.keterangan)
                .toList();
            final message = getList.join(', ');
            return TileOption(
              title: 'Topping'.tr,
              svgPicture: ImageConstant.ic_topping,
              titleStyle: Get.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              message: message,
              messageStyle: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 15,
              ),
              onTap: (food.topping.isNotEmpty)
                  ? () => DetailFoodController.to.selectOption('topping')
                  : null,
            );
          }),
        ),
        const CustomDivider(thickness: 0.2),
        Container(
          height: heightTileOption,
          margin: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Obx(
            () => TileOption(
              title: 'Catatan'.tr,
              svgPicture: ImageConstant.ic_catatan,
              titleStyle: Get.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              message: DetailFoodController.to.catatan.value,
              messageStyle: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 15,
              ),
              onTap: () => DetailFoodController.to.selectOption('catatan'),
            ),
          ),
        ),
        const CustomDivider(thickness: 0.2),
        40.verticalSpacingRadius,
        ElevatedButton(
          onPressed: DetailFoodController.to.checkout,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(1.sw, 45.h),
            backgroundColor: MainColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          child: Text(
            'Tambahkan ke Pesanan'.tr,
            style: Get.textTheme.titleMedium!.copyWith(
              color: MainColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
