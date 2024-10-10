import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/chekout/controllers/voucher_controller.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';

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
                return Container(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
