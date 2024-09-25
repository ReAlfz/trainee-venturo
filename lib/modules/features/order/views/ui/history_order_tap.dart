import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';
import 'package:trainee/modules/features/order/views/components/date_picker.dart';
import 'package:trainee/modules/features/order/views/components/dropdown_status.dart';
import 'package:trainee/modules/features/order/views/components/order_item_card.dart';

class HistoryOrderTapView extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const HistoryOrderTapView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());
    analytics.setCurrentScreen(
      screenName: 'Order History Screen',
      screenClassOverride: 'Trainee',
    );

    return RefreshIndicator(
      onRefresh: () async => controller.getOrderHistory(),
      child: Obx(() => ConditionalSwitch.single(
        context: context,
        valueBuilder: (context) => controller.onOrderHistoryState,
        caseBuilders: {},
        fallbackBuilder: (context) => CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownStatus(
                        items: controller.dateFilterStatus,
                        selectedItem: controller.selectCategory.value,
                        onChanged: (value) => controller.setDateFilter(category: value),
                      ),
                    ),
                    22.horizontalSpaceRadius,
                    Expanded(
                      child: DatePicker(
                        selectDate: controller.selectDateRange.value,
                        onChanged: (value) => controller.setDateFilter(range: value),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Conditional.single(
              context: context,
              conditionBuilder: (context) => controller.filterHistoryOrder.isNotEmpty,
              widgetBuilder: (context) => SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 16.r),
                      child: OrderItemCard(
                        order: controller.filterHistoryOrder[index],
                        onOrderAgain: () {},
                        onTap: () => Get.toNamed('${MainRoute.home}/${controller.filterHistoryOrder[index].idOrder}',
                        ),
                      ),
                    ),
                    childCount: controller.filterHistoryOrder.length,
                  ),
                ),
              ),
              fallbackBuilder: (context) => const SliverToBoxAdapter(child: SizedBox()),
            ),
          ],
        )
      )),
    );
  }
}