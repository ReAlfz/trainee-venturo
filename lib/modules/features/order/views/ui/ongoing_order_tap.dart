import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';
import 'package:trainee/modules/features/order/views/components/order_item_card.dart';

class OnGoingOrderTabView extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const OnGoingOrderTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );

    return SizedBox(
      height: 1.sh,
      child: Obx(() => SmartRefresher(
        controller: controller.refreshControllerOnGoingOrder,
        onRefresh: controller.onRefreshOnGoingOrder,
        onLoading: controller.onLoadingOnGoingOrder,
        enablePullUp: controller.canLoadMore.isTrue ? true : false,
        enablePullDown: true,
        child: ListView.separated(
          padding: EdgeInsets.all(25.r),
          itemCount: controller.listOrder.length,
          itemBuilder: (context, index) => OrderItemCard(
            order: controller.listOrder[index],
            onTap: () => Get.toNamed('${MainRoute.home}/order/${controller.allOnGoingOrder[index].idOrder}'),
            onOrderAgain: () {},
          ),
          separatorBuilder: (context, index) => 16.verticalSpace,
        ),
      )),
    );
  }
}