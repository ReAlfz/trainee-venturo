import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';
import 'package:trainee/modules/features/order/views/components/order_item_card.dart';

class OnGoingOrderTabView extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const OnGoingOrderTabView({super.key});

  @override
  Widget build(BuildContext context) {
    print('onGoingView');
    final OrderController controller = Get.put(OrderController());
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );

    return RefreshIndicator(
      onRefresh: () async => controller.getOngoingOrder(),
      child: Obx(() => ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(25.r),
        itemCount: controller.onGoingOrder.length,
        itemBuilder: (context, index) => OrderItemCard(
          order: controller.onGoingOrder[index],
          onTap: () => Get.toNamed('${MainRoute.home}/${controller.onGoingOrder[index].idOrder}'),
          onOrderAgain: () {},
        ),
        separatorBuilder: (context, index) => 16.verticalSpace,
      )),
    );
  }
}