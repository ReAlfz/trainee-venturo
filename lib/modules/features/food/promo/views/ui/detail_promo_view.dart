import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/food/promo/controllers/detail_promo_controller.dart';
import 'package:trainee/modules/features/food/promo/views/components/html_parser.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';

class DetailPromoView extends StatelessWidget {
  const DetailPromoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: RoundedAppBar(
          title: 'Promo'.tr,
          svgPicture: ImageConstant.ic_promo,
          onBackPressed: DetailPromoController.to.backPromo,
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
                        DetailPromoController.to.promoState.value == 'success',
                    widgetBuilder: (context) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 32.5.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            DetailPromoController.to.foto.value,
                          ),
                          fit: (DetailPromoController.to.foto.value ==
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png')
                              ? BoxFit.contain
                              : BoxFit.cover,
                          onError: (exception, stackTrace) {
                            DetailPromoController.to.foto.value =
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
                          DetailPromoController.to.promoState.value ==
                          'success',
                      widgetBuilder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Promo'.tr,
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: 18.sp,
                              ),
                            ),
                            15.verticalSpace,
                            Text(
                              DetailPromoController.to.promo.value!.nama.tr,
                              maxLines: 2,
                              style: Get.textTheme.titleLarge!.copyWith(
                                color: MainColor.primary,
                                fontSize: 20.sp,
                              ),
                            ),
                            20.verticalSpace,
                            Divider(color: Colors.grey[500]),
                            5.verticalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageConstant.ic_syarat,
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        'Syarat dan Ketentuan'.tr,
                                        style:
                                            Get.textTheme.bodyLarge!.copyWith(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 0.09.sw),
                                          Expanded(
                                            child: HtmlParser(
                                              htmlData: DetailPromoController.to
                                                  .promo.value!.syaratKetentuan,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
