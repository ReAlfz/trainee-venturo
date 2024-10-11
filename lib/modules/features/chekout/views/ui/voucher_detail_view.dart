import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trainee/modules/features/chekout/controllers/voucher_detail_controller.dart';
import 'package:trainee/shared/widgets/html_parser.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';

import '../../../../../configs/themes/main_color.dart';

class VoucherDetailView extends StatelessWidget {
  const VoucherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: RoundedAppBar(
          title: 'Detail Voucher'.tr,
          enableBackButton: true,
        ),
        body: SizedBox(
          height: 1.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Obx(
                      () => Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                    VoucherDetailController.to.voucherState.value == 'success',
                    widgetBuilder: (context) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 32.5.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            VoucherDetailController.to.foto.value,
                          ),
                          fit: (VoucherDetailController.to.foto.value ==
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png')
                              ? BoxFit.contain
                              : BoxFit.cover,
                          onError: (exception, stackTrace) {
                            VoucherDetailController.to.foto.value =
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
                          },
                        ),
                      ),
                    ),
                    fallbackBuilder: (context) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                        height: 1.sh,
                        width: 250.w,
                        margin: EdgeInsets.symmetric(vertical: 10.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: Container(
                  width: 1.sw,
                  height: 1.sh,
                  padding:
                  EdgeInsets.symmetric(horizontal: 25.r, vertical: 40.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, -2),
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Obx(
                        () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      VoucherDetailController.to.voucherState.value ==
                          'success',
                      widgetBuilder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              VoucherDetailController.to.voucherData.value!.nama.tr,
                              maxLines: 2,
                              style: Get.textTheme.titleLarge!.copyWith(
                                color: MainColor.primary,
                                fontSize: 20.sp,
                              ),
                            ),
                            10.verticalSpace,
                            HtmlParser(
                              htmlData: VoucherDetailController.to.voucherData.value!.catatan,
                            ),
                            40.verticalSpace,
                            Divider(color: Colors.grey[500]),
                            5.verticalSpace,
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  color: MainColor.primary,
                                  size: 20.r,
                                ),
                                7.5.horizontalSpace,
                                Text(
                                  'Valid Date'.tr,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const Expanded(child: SizedBox()),

                                Text(
                                  VoucherDetailController.to.date.value,
                                  style: Get.textTheme.bodySmall!.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Divider(color: Colors.grey[500]),
                          ],
                        );
                      },
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