import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:trainee/configs/themes/main_color.dart';

class PinDialog extends StatefulWidget {
  final String pin;

  const PinDialog({super.key, required this.pin});

  @override
  State<StatefulWidget> createState() => _PinDialog();
}

class _PinDialog extends State<PinDialog> {
  final RxBool obscure = RxBool(true);
  final RxnString errorText = RxnString();
  final TextEditingController controller = TextEditingController();
  int tries = 0;

  Future<void> processPin(String? pin) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (pin == widget.pin) {
      Get.back<bool>(result: true);
    } else {
      tries++;

      if (tries >= 3) {
        Get.back<bool>(result: false);
      } else {
        controller.clear();
        errorText.value =
            'Pin wrong!, ${(3 - tries).toString()} chances left'.tr;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 40.h,
      textStyle: Get.textTheme.titleLarge,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
        horizontal: 12.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Verify Order'.tr,
            style: Get.textTheme.labelLarge!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Enter Pin'.tr,
            style: Get.textTheme.bodySmall!.copyWith(
              color: MainColor.black,
              fontSize: 15,
            ),
          ),
          24.verticalSpacingRadius,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Expanded(
                    child: Pinput(
                      controller: controller,
                      showCursor: false,
                      length: 6,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      closeKeyboardWhenCompleted: false,
                      defaultPinTheme: defaultPinTheme,
                      obscuringCharacter: '*',
                      obscureText: obscure.value,
                      onSubmitted: processPin,
                      onCompleted: processPin,
                      separatorBuilder: (index) {
                        if (index == 1 || index == 3) {
                          return const Text('-');
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  )),
              10.horizontalSpace,
              Obx(() => InkWell(
                    radius: 24.r,
                    onTap: () => obscure.value = !obscure.value,
                    child: Icon(
                      obscure.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                      size: 20.r,
                    ),
                  )),
            ],
          ),
          10.verticalSpace,
          Obx(
            () => (errorText.value != null)
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 15.r,
                      right: 15.r,
                      top: 10.r,
                    ),
                    child: Text(
                      errorText.value!.tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
