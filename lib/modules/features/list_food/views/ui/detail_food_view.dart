import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/list_food/controllers/detail_food_controller.dart';
import 'package:trainee/modules/features/list_food/views/components/detail_food_app_bar.dart';
import 'package:trainee/shared/widgets/quantitiy_counter.dart';
import 'package:trainee/shared/widgets/tile_option.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          DetailFoodController.to.updateData();
          return false;
        },
        child: Scaffold(
          appBar: const CatalogAppbar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Obx(() => Conditional.single(
                  context: context,
                  conditionBuilder: (context) => DetailFoodController.to.catalogState.value == 'success',
                  fallbackBuilder: (context) => SizedBox(height: 1.sh),
                  widgetBuilder: (context) => CachedNetworkImage(
                    imageUrl: DetailFoodController.to.catalogData.value!.menu.foto,
                    height: 1.sh,
                    fit: BoxFit.fitHeight,
                    errorWidget: (context, url, error) {
                      return CachedNetworkImage(
                        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                        height: 1.sh,
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                )),
              ),

              Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.r,
                    vertical: 10.r
                  ),
                  decoration: BoxDecoration(
                    color: MainColor.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: MainColor.black,
                        offset: Offset(0, 1),
                        spreadRadius: 0.3,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Obx(() => Conditional.single(
                    context: context,
                    conditionBuilder: (context) => DetailFoodController.to.catalogState.value == 'success',
                    widgetBuilder: (context) {
                      final food = DetailFoodController.to.catalogData.value!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        food.menu.nama,
                                        style: Get.textTheme.labelLarge!.copyWith(
                                            color: MainColor.primary,
                                            fontSize: 20.sp
                                        ),
                                      ),

                                      Container(
                                        height: 50.r,
                                        padding: EdgeInsets.only(left: 12.r, right: 5.r),
                                        child: InkWell(
                                          splashFactory: NoSplash.splashFactory,
                                          child: QuantityCounter(
                                            quantity: DetailFoodController.to.quantity.value,
                                            onIncrement: DetailFoodController.to.onIncrease,
                                            onDecrement: DetailFoodController.to.onDecrease,
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
                            )
                          ),

                          30.verticalSpacingRadius,

                          IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(thickness: 0.2, color: Colors.black54, height: 1),
                                SizedBox(
                                  height: 55.h,
                                  child: TileOption(
                                    title: 'Harga',
                                    svgPicture: ImageConstant.ic_harga,
                                    titleStyle: Get.textTheme.titleMedium,
                                    message: 'Rp ${food.menu.harga}',
                                    messageStyle: Get.textTheme.titleMedium!.copyWith(
                                      color: MainColor.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Divider(thickness: 0.2, color: Colors.black54, height: 1),
                                SizedBox(
                                  height: 55.h,
                                  child: (food.level.isEmpty)
                                      ? TileOption(
                                    title: 'Level',
                                    svgPicture: ImageConstant.ic_level,
                                    titleStyle: Get.textTheme.titleMedium,
                                    message: '',
                                    messageStyle: Get.textTheme.titleMedium,
                                  )
                                      : TileOption(
                                    title: 'Level',
                                    svgPicture: ImageConstant.ic_level,
                                    titleStyle: Get.textTheme.titleMedium,
                                    message: food.level.first.keterangan,
                                    messageStyle: Get.textTheme.titleMedium,
                                    onTap: () {},
                                  ),
                                ),
                                const Divider(thickness: 0.2, color: Colors.black54, height: 1),
                                SizedBox(
                                  height: 55.h,
                                  child: (food.topping.isEmpty)
                                      ? TileOption(
                                    title: 'Topping',
                                    svgPicture: ImageConstant.ic_topping,
                                    titleStyle: Get.textTheme.titleMedium,
                                    message: '',
                                    messageStyle: Get.textTheme.titleMedium,
                                  )
                                      : TileOption(
                                    title: 'Topping',
                                    svgPicture: ImageConstant.ic_topping,
                                    titleStyle: Get.textTheme.titleMedium,
                                    message: food.topping.first.keterangan,
                                    messageStyle: Get.textTheme.titleMedium,
                                    onTap: () {},
                                  ),
                                ),
                                const Divider(thickness: 0.2, color: Colors.black54, height: 1),
                                SizedBox(
                                  height: 55.h,
                                  child: TileOption(
                                    title: 'Catatan',
                                    svgPicture: ImageConstant.ic_catatan,
                                    titleStyle: Get.textTheme.titleMedium,
                                    message: (DetailFoodController.to.menu.value!.catatan == '')
                                        ? 'tambahkan catatan'
                                        : DetailFoodController.to.menu.value!.catatan,
                                    messageStyle: Get.textTheme.titleMedium,
                                    onTap: () {},
                                  ),
                                ),
                                const Divider(thickness: 0.2, color: Colors.black54, height: 1),
                              ],
                            ),
                          ),

                          40.verticalSpacingRadius,

                          IntrinsicHeight(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(1.sw, 45.h),
                                backgroundColor: MainColor.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: Text(
                                'Tambahkan ke Pesanan',
                                style: Get.textTheme.titleMedium!.copyWith(
                                  color: MainColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}