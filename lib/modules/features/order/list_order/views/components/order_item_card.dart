import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainee/modules/features/order/list_order/views/components/primary_button_with_title.dart';

import '../../modules/order_model.dart';
import 'outline_title_button.dart';

class OrderItemCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  final VoidCallback? onOrderAgain;
  final ValueChanged<int>? onGiveReview;

  const OrderItemCard({super.key, required this.order, this.onTap, this.onOrderAgain, this.onGiveReview});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: Colors.black87,
            ),
          ],
        ),

        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                child: Hero(
                  tag: 'order-${order.idOrder}',
                  child: Container(
                    width: 124.w,
                    padding: EdgeInsets.all(10.r),
                    constraints: BoxConstraints(
                      minHeight: 124.h,
                      maxWidth: 124.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey[300],
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      height: 75.h,
                      width: 75.w,
                      imageUrl: order.menu.isNotEmpty
                          ? order.menu.first.foto
                          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                      errorWidget: (context, url, error) {
                        return CachedNetworkImage(
                          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                          fit: BoxFit.contain,
                          height: 75.h,
                          width: 75.w,
                        );
                      }
                    ),
                  ),
                ),
              ),

              12.horizontalSpace,

              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.verticalSpace,

                    Row(
                      children: [
                        if (order.status == 0)
                          Icon(
                            Icons.access_time,
                            color: const Color(0xFFFFAC01),
                            size: 16.r,
                          ),
                        if (order.status == 1)
                          Icon(
                            Icons.access_time,
                            color: const Color(0xFFFFAC01),
                            size: 16.r,
                          ),
                        if (order.status == 2)
                          Icon(
                            Icons.access_time,
                            color: const Color(0xFFFFAC01),
                            size: 16.r,
                          ),
                        if (order.status == 3)
                          Icon(
                            Icons.check,
                            color: const Color(0xFF009C48),
                            size: 16.r,
                          ),
                        if (order.status == 4)
                          Icon(
                            Icons.close,
                            color: const Color(0xFFD81D1D),
                            size: 16.r,
                          ),
                        
                        5.horizontalSpaceRadius,
                        
                        Expanded(
                          child: ConditionalSwitch.single(
                            context: context,
                            valueBuilder: (context) => order.status,
                            fallbackBuilder: (context) => const SizedBox(),
                            caseBuilders: {
                              0: (context) => Text(
                                'In queue'.tr,
                                style: Get.textTheme.labelMedium!.copyWith(
                                    color: const Color(0xFFFFAC01)),
                              ),
                              1: (context) => Text(
                                'Preparing'.tr,
                                style: Get.textTheme.labelMedium!.copyWith(
                                    color: const Color(0xFFFFAC01)),
                              ),
                              2: (context) => Text(
                                'Ready'.tr,
                                style: Get.textTheme.labelMedium!.copyWith(
                                    color: const Color(0xFFFFAC01)),
                              ),
                              3: (context) => Text(
                                'Completed'.tr,
                                style: Get.textTheme.labelMedium!.copyWith(
                                    color: const Color(0xFF009C48)),
                              ),
                              4: (context) => Text(
                                'Canceled'.tr,
                                style: Get.textTheme.labelMedium!.copyWith(
                                    color: const Color(0xFFD81D1D)),
                              ),
                            },
                          ),
                        ),

                        Text(
                          DateFormat('dd MMM yyyy', Get.locale?.countryCode)
                              .format(DateTime.parse(order.tanggal)),
                          style: Get.textTheme.labelMedium!.copyWith(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),

                    14.verticalSpace,

                    Text(
                      order.menu.map((element) => element.nama).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Get.textTheme.bodyMedium,
                    ),

                    5.verticalSpace,

                    Row(
                      children: [
                        Text(
                          'Rp ${order.totalBayar}',
                          style: Get.textTheme.labelLarge!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        5.horizontalSpace,
                        Text(
                          '(${order.menu.length} Menu)',
                          style: Get.textTheme.labelLarge!
                              .copyWith(color: Colors.grey[400]),
                        ),
                      ],
                    ),

                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => order.status == 3 || order.status == 4,
                      widgetBuilder: (context) => Wrap(
                        spacing: 15.r,
                        children: [
                          if (order.status == 3)
                            Padding(
                              padding: EdgeInsets.only(top: 10.r, bottom: 5.r),
                              child: OutlinedTittleButton.compact(
                                text: 'Give review'.tr,
                                onPressed: () => onGiveReview?.call(order.idOrder),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.r,
                              bottom: 5.r,
                              right: order.status == 3 ? 0.r : 0.3.sw,
                            ),
                            child: PrimaryButtonWithTitle.compact(
                              title: 'Order again'.tr,
                              onPressed: onOrderAgain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              5.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}