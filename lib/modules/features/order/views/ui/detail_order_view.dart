import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/views/components/tile_option.dart';
import 'package:trainee/modules/features/home/views/components/section_header.dart';
import 'package:trainee/modules/features/order/controllers/detail_order_controller.dart';
import 'package:trainee/modules/features/order/views/components/order_list_sliver.dart';
import 'package:trainee/modules/features/order/views/components/order_tracker.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';

class DetailOrderView extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const DetailOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Detail Order Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: RoundedAppBar(
        title: 'Order',
        iconData: Icons.shopping_bag_outlined,
        enableBackButton: true,
        actions: [
          Obx(() => Conditional.single(
            context: context,
            conditionBuilder: (context) => DetailOrderController.to.order.value?.status == 0,
            widgetBuilder: (context) => Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(
                  'Cancel'.tr,
                  style: Get.textTheme.labelLarge
                      ?.copyWith(color: const Color(0xFFD81D1D)),
                ),
              ),
            ),

            fallbackBuilder: (context) => const SizedBox(),
          )),
        ],
      ),

      body: Obx(() => ConditionalSwitch.single(
        context: context,
        valueBuilder: (context) => DetailOrderController.to.orderDetailState.value,
        caseBuilders: {},
        fallbackBuilder: (context) => CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: 28.verticalSpace),
            if (DetailOrderController.to.foodItem.isNotEmpty) ...[
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
                sliver: OrderListSliver(
                  listMenu: DetailOrderController.to.foodItem,
                ),
              )
            ],
            SliverToBoxAdapter(child: 17.verticalSpace),
            if (DetailOrderController.to.drinkItem.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: SectionHeader(
                  icon: Icons.food_bank_outlined,
                  title: 'Drink',
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SliverPadding(
                padding:
                EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                sliver: OrderListSliver(
                  listMenu: DetailOrderController.to.drinkItem,
                ),
              )
            ],
          ],
        ),
      )),

      bottomNavigationBar:  Obx(() => Conditional.single(
        context: context,
        conditionBuilder: (context) => DetailOrderController.to.orderDetailState.value == 'success',
        fallbackBuilder: (context) => const SizedBox(),
        widgetBuilder: (context) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TileOption(
                      title: 'Total orders',
                      subtitle: '(${DetailOrderController.to.order.value?.menu.length} Menu):',
                      message: 'Rp ${DetailOrderController.to.order.value?.totalBayar ?? '0'}',
                      titleStyle: Get.textTheme.titleMedium,
                      messageStyle: Get.textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Divider(color: Colors.black45, height: 2.h),

                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => DetailOrderController.to.order.value?.diskon == 1
                          && DetailOrderController.to.order.value!.potongan > 0,
                      widgetBuilder: (context) => TileOption(
                        icon: Icons.discount_outlined,
                        iconSize: 24.r,
                        title: 'Discount',
                        message: 'Rp ${DetailOrderController.to.order.value?.potongan ?? '0'}',
                        titleStyle: Get.textTheme.titleMedium,
                        messageStyle: Get.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFD81D1D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),

                    Divider(color: Colors.black54, height: 2.h),

                    // Vouchers tile
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => DetailOrderController.to.order.value?.idVocher != 0,
                      widgetBuilder: (context) => TileOption(
                        icon: Icons.discount,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: 'Rp ${DetailOrderController.to.order.value?.potongan ?? '0'}',
                        messageSubtitle: DetailOrderController.to.order.value?.namaVocher,
                        titleStyle: Get.textTheme.titleMedium,
                        messageStyle: Get.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFD81D1D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),

                    Divider(color: const Color(0xFFD81D1D), height: 2.h),

                    // Payment options tile
                    TileOption(
                      icon: Icons.payment_outlined,
                      iconSize: 24.r,
                      title: 'Payment'.tr,
                      message: 'Pay Later',
                      titleStyle: Get.textTheme.titleMedium,
                      messageStyle: Get.textTheme.titleMedium,
                    ),

                    Divider(color: Colors.black54, height: 2.h),

                    // total payment
                    TileOption(
                      iconSize: 24.r,
                      title: 'Total payment'.tr,
                      message:
                      'Rp ${DetailOrderController.to.order.value?.totalBayar ?? '0'}',
                      titleStyle: Get.textTheme.titleMedium,
                      messageStyle: Get.textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(color: Colors.black54, height: 2.h),
                    24.verticalSpace,

                    // order status track
                    const OrderTracker(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}