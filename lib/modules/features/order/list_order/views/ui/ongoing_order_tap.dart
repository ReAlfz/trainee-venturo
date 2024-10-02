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
import '../components/order_item_card.dart';

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
      child: Obx(
        () => SmartRefresher(
          controller: controller.refreshControllerOnGoingOrder,
          onRefresh: controller.onRefreshOnGoingOrder,
          onLoading: controller.onLoadingOnGoingOrder,
          enablePullUp: controller.canLoadMore.isTrue ? true : false,
          enablePullDown: true,
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) => controller.listOrder.isNotEmpty,
            widgetBuilder: (context) {
              return ListView.separated(
                padding: EdgeInsets.all(25.r),
                itemCount: controller.listOrder.length,
                itemBuilder: (context, index) {
                  return OrderItemCard(
                    order: controller.listOrder[index],
                    onTap: () => Get.toNamed(
                        '${MainRoute.home}/order/${controller.allOnGoingOrder[index].idOrder}'),
                    onOrderAgain: () {},
                  );
                },
                separatorBuilder: (context, index) => 16.verticalSpace,
              );
            },
            fallbackBuilder: (context) => Container(
              height: 640.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstant.ic_empty_list_order,
                    fit: BoxFit.cover,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already ordered?'.tr,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: '\nTrack your order\nhere.'.tr,
                          style: Get.textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
