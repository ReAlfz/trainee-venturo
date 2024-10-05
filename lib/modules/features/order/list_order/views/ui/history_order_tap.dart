import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
    analytics.setCurrentScreen(
      screenName: 'Order History Screen',
      screenClassOverride: 'Trainee',
    );

    return SizedBox(
      height: 1.sh,
      child: Obx(
        () => SmartRefresher(
          controller: OrderController.to.refreshControllerHistoryOrder,
          onLoading: OrderController.to.onLoadingHistoryOrder,
          onRefresh: OrderController.to.onRefreshHistoryOrder,
          enablePullUp: OrderController.to.canLoadMore.isTrue ? true : false,
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
                          items: OrderController.to.dateFilterStatus,
                          selectedItem: OrderController.to.selectCategory.value,
                          onChanged: (value) =>
                              OrderController.to.setDateFilter(category: value),
                        ),
                      ),
                      22.horizontalSpaceRadius,
                      Expanded(
                        child: DatePicker(
                          selectDate: OrderController.to.selectDateRange.value,
                          onChanged: (value) =>
                              OrderController.to.setDateFilter(range: value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    OrderController.to.filterHistoryOrder.isNotEmpty,
                widgetBuilder: (context) => SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 16.r),
                        child: OrderItemCard(
                          order: OrderController.to.filterHistoryOrder[index],
                          onOrderAgain: () {},
                          onTap: () => OrderController.to
                              .pushOrder(index: index, currentPage: false),
                        ),
                      ),
                      childCount: OrderController.to.filterHistoryOrder.length,
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
                                  'your favorite menu again!'
                              .tr,
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
