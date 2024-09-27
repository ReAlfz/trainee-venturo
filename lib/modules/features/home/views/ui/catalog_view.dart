import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/home/controllers/catalog_controller.dart';
import 'package:trainee/modules/features/home/controllers/list_controller.dart';
import 'package:trainee/modules/features/home/views/components/catalog_app_bar.dart';
import 'package:trainee/shared/customs/elevated_button_sign_in.dart';
import 'package:trainee/shared/widgets/quantitiy_counter.dart';
import 'package:trainee/shared/widgets/tile_option.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CatalogAppbar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Obx(() => Conditional.single(
                context: context,
                conditionBuilder: (context) => CatalogController.to.catalogState.value == 'success',
                fallbackBuilder: (context) => SizedBox(height: 1.sh),
                widgetBuilder: (context) => Image.network(
                  CatalogController.to.catalogData!.menu.foto,
                  height: 1.sh,
                  fit: BoxFit.fitHeight,
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
                  conditionBuilder: (context) => CatalogController.to.catalogState.value == 'success',
                  widgetBuilder: (context) {
                    final catalog = CatalogController.to.catalogData!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        20.verticalSpacingRadius,
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                catalog.menu.nama,
                                style: Get.textTheme.labelLarge!.copyWith(
                                    color: MainColor.primary,
                                    fontSize: 20.sp
                                ),
                              ),

                              Container(
                                height: 75.r,
                                padding: EdgeInsets.only(left: 12.r, right: 5.r),
                                child: InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  child: QuantityCounter(
                                    quantity: catalog.menu.jumlah,
                                    onIncrement: () {},
                                    onDecrement: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Text(
                            catalog.menu.deskripsi,
                            style: Get.textTheme.bodySmall,
                          ),
                        ),

                        10.verticalSpacingRadius,

                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              TileOption(
                                title: 'Harga',
                                titleStyle: Get.textTheme.titleMedium,
                                message: 'Rp. ${catalog.menu.harga}',
                                messageStyle: Get.textTheme.titleMedium!.copyWith(
                                  color: MainColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(),
                              TileOption(
                                title: 'Level',
                                titleStyle: Get.textTheme.titleMedium,
                                message: (catalog.level.isEmpty) ? '' : catalog.level.first.keterangan,
                                messageStyle: Get.textTheme.titleMedium,
                              ),
                              const Divider(),
                              TileOption(
                                title: 'Topping',
                                titleStyle: Get.textTheme.titleMedium,
                                message: (catalog.topping.isEmpty) ? '' : catalog.topping.first.keterangan,
                                messageStyle: Get.textTheme.titleMedium,
                              ),
                              const Divider(),
                              TileOption(
                                title: 'Catatan',
                                titleStyle: Get.textTheme.titleMedium,
                                message: (catalog.menu.catatan == '')
                                    ? 'tulis catatan di sini'
                                    : catalog.menu.catatan,
                                messageStyle: Get.textTheme.titleMedium,
                              ),
                              const Divider(),
                            ],
                          ),
                        ),

                        10.verticalSpacingRadius,

                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
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

            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}