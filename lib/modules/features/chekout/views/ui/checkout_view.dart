import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/chekout/views/components/cart_list_sliver.dart';
import 'package:trainee/modules/features/chekout/views/components/cart_order_bottom_bar.dart';
import 'package:trainee/modules/features/list_food/views/components/section_header.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';
import 'package:trainee/shared/widgets/tile_option.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoundedAppBar(
        title: 'Pesanan',
        iconData: Icons.shopping_cart,
      ),

      body: Column(
        children: [
          Expanded(
            child: Obx(() => CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: 28.verticalSpace),
                if (CheckoutController.to.foodItems.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: SectionHeader(
                      icon: Icons.food_bank_outlined,
                      title: 'Food',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                    sliver: CartListSliver(
                      cart: CheckoutController.to.foodItems,
                    ),
                  )
                ],
                SliverToBoxAdapter(child: 17.verticalSpace),
                if (CheckoutController.to.drinkItems.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: SectionHeader(
                      icon: Icons.local_drink_outlined,
                      title: 'Drink',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                    sliver: CartListSliver(
                      cart: CheckoutController.to.drinkItems,
                    ),
                  )
                ],
              ],
            )),
          ),

          Obx(() => Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
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
                        title: 'Total Pesanan (${CheckoutController.to.cart.length} Menu) :',
                        message: 'Rp ${CheckoutController.to.totalPrice.toString()}',
                        titleStyle: Get.textTheme.bodyLarge,
                        messageStyle: Get.textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const Divider(color: Colors.grey, thickness: 0.5),

                      TileOption(
                        title: 'Discount',
                        message: 'Rp ${CheckoutController.to.discountPrice.toString()}',
                        svgPicture: ImageConstant.ic_discount,
                        titleStyle: Get.textTheme.bodyLarge,
                        messageStyle: Get.textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onTap: () {},
                      ),

                      const Divider(color: Colors.grey, thickness: 0.5),

                      TileOption(
                        title: 'Voucher',
                        message: 'Rp ${CheckoutController.to.discountPrice.toString()}',
                        svgPicture: ImageConstant.ic_voucher,
                        titleStyle: Get.textTheme.bodyLarge,
                        messageStyle: Get.textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onTap: () {},
                      ),

                      const Divider(color: Colors.grey, thickness: 0.5),

                      TileOption(
                        title: 'Payment',
                        message: 'Pay later',
                        svgPicture: ImageConstant.ic_payment_method,
                        titleStyle: Get.textTheme.bodyLarge,
                        messageStyle: Get.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),

                CartOrderBottomBar(
                  totalPrice: 'Rp. ${CheckoutController.to.grandTotal}',
                  onOrderPressed: CheckoutController.to.verify,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}