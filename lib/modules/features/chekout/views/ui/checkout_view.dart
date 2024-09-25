import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/chekout/views/components/cart_list_sliver.dart';
import 'package:trainee/modules/features/chekout/views/components/cart_order_bottom_bar.dart';
import 'package:trainee/modules/features/chekout/views/components/rounded_custom_appbar.dart';
import 'package:trainee/modules/features/chekout/views/components/tile_option.dart';
import 'package:trainee/modules/features/home/views/components/section_header.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.put(CheckoutController());
    return Scaffold(
      appBar: const RoundedAppBar(
        title: 'Order',
        iconData: Icons.shopping_cart,
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(() => CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: 28.verticalSpace),
              if (controller.foodItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.food_bank_outlined,
                    title: 'Food',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: CartListSliver(
                    cart: controller.foodItems,
                  ),
                )
              ],
              SliverToBoxAdapter(child: 17.verticalSpace),
              if (controller.drinkItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.local_drink_outlined,
                    title: 'Drink',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: CartListSliver(
                    cart: controller.drinkItems,
                  ),
                )
              ],
            ],
          )),

          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                )
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 25.h, horizontal: 22.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TileOption(
                          title: 'Total Orders',
                          message: 'Rp. ${controller.totalPrice.toString()}',
                          icon: Icons.payment_outlined,
                          titleStyle: Get.textTheme.bodyLarge,
                          messageStyle: Get.textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),

                        Divider(color: Colors.black54, height: 2.h),

                        TileOption(
                          title: 'Discount',
                          message: 'Rp. ${controller.discountPrice.toString()}',
                          iconSize: 24.r,
                          icon: Icons.discount_outlined,
                          titleStyle: Get.textTheme.bodyLarge,
                          messageStyle: Get.textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),

                        TileOption(
                          title: 'Payment',
                          message: 'Pay later',
                          icon: Icons.payment_outlined,
                          titleStyle: Get.textTheme.bodyLarge,
                          messageStyle: Get.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),

                  CartOrderBottomBar(
                    totalPrice: 'Rp. ${controller.grandTotal}',
                    onOrderPressed: controller.verify,
                  ),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}