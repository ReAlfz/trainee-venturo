import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/chekout/controllers/voucher_controller.dart';
import 'package:trainee/modules/features/food/promo/controllers/detail_promo_controller.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';

import '../../../../../shared/customs/elevated_button_sign_in.dart';

class VoucherView extends StatelessWidget {
  const VoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: RoundedAppBar(
          title: 'Pilih Voucher'.tr,
          svgPicture: ImageConstant.ic_voucher,
          heightSvg: 18.h,
          widthSvg: 18.w,
          enableBackButton: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: 1.sh,
          child: Obx(
            () => ListView.separated(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: VoucherController.to.list.length,
              separatorBuilder: (context, index) => 20.verticalSpace,
              itemBuilder: (context, index) {
                final voucher = VoucherController.to.list[index];
                return GestureDetector(
                  onTap: () => VoucherController.to.pushDetail(voucher: voucher),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    height: 225.h,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 42.5.h,
                          child: Obx(
                                () => CheckboxListTile(
                              dense: true,
                              title: Text(
                                voucher.nama,
                                style: Get.textTheme.displaySmall!.copyWith(
                                  fontSize: 15.5.sp,
                                  color: MainColor.black,
                                ),
                              ),
                              value: VoucherController.to.selectedIndex.value ==
                                  index,
                              onChanged: (value) {
                                (value == true)
                                    ? VoucherController.to.selectedIndex.value =
                                    index
                                    : VoucherController.to.selectedIndex.value =
                                null;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: CachedNetworkImage(
                              imageUrl: voucher.infoVoucher,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        bottomSheet: Container(
          height: 115.h,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline_outlined,
                    color: MainColor.primary,
                  ),
                  10.horizontalSpace,
                  RichText(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                      text: 'Penggunaan voucher tidak dapat digabung dengan\n'.tr,
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'discount employee reward program'.tr,
                          style: Get.textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: MainColor.primary,
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              ElevatedButtonCustom(
                title: 'Oke',
                bg_color: MainColor.primary,
                text_color: MainColor.white,
                function: VoucherController.to.onBack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
