import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

import '../../controllers/order_controller.dart';
import '../components/date_picker.dart';
import '../components/dropdown_status.dart';
import '../components/order_item_card.dart';

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

    return SizedBox(
      height: 1.sh,
      child: Obx(
        () => SmartRefresher(
          controller: controller.refreshControllerHistoryOrder,
          onLoading: controller.onLoadingHistoryOrder,
          onRefresh: controller.onRefreshHistoryOrder,
          enablePullUp: controller.canLoadMore.isTrue ? true : false,
          enablePullDown: true,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownStatus(
                          items: controller.dateFilterStatus,
                          selectedItem: controller.selectCategory.value,
                          onChanged: (value) =>
                              controller.setDateFilter(category: value),
                        ),
                      ),
                      22.horizontalSpaceRadius,
                      Expanded(
                        child: DatePicker(
                          selectDate: controller.selectDateRange.value,
                          onChanged: (value) =>
                              controller.setDateFilter(range: value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    controller.filterHistoryOrder.isNotEmpty,
                widgetBuilder: (context) => SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 16.r),
                        child: OrderItemCard(
                          order: controller.filterHistoryOrder[index],
                          onOrderAgain: () {},
                          onTap: () => Get.toNamed(
                            '${MainRoute.home}/order/${controller.filterHistoryOrder[index].idOrder}',
                          ),
                        ),
                      ),
                      childCount: controller.filterHistoryOrder.length,
                    ),
                  ),
                ),
                fallbackBuilder: (context) => SliverToBoxAdapter(
                  child: Container(
                    height: 515.h,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstant.ic_empty_list_order,
                          fit: BoxFit.cover,
                        ),

                        Text(
                          'Start making orders'.tr,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        7.5.verticalSpace,
                        Text(
                          'The food you ordered\n'
                              'will appear here so that\n'
                              'You can find\n'
                              'your favorite menu again!'.tr,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
