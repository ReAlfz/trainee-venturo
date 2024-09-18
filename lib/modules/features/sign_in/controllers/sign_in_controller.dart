import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/api/api_constant.dart';
import 'package:trainee/shared/global_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var emailValue = "".obs;

  var passwordCtrl = TextEditingController();
  var passwordValue = "".obs;

  var isPassword = true.obs;
  var isRememberMe = false.obs;

  void showPassword() => isPassword.value = !isPassword.value;

  void validateForm(context) async {
    await GlobalController.to.checkConnection();

    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang Diproses...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );

      formKey.currentState!.save();
      if (emailCtrl.text == "admin@gmail.com" && passwordCtrl.text == "admin") {
        EasyLoading.dismiss();
        Get.offAllNamed(MainRoute.splash);
      } else {
        EasyLoading.dismiss();
        PanaraInfoDialog.show(
          context,
          title: "Warning",
          message: "Email & Password Salah",
          buttonText: "Coba lagi",
          onTapDismiss: () {
            Get.back();
          },
          panaraDialogType: PanaraDialogType.warning,
          barrierDismissible: false,
        );
      }

    } else if (GlobalController.to.isConnect.value == false) {
      Get.toNamed(MainRoute.noConnection);
    }
  }

  void flavorSetting() async {
    Get.bottomSheet(
      Obx(() => Wrap(
        children: [
          Container(
            width: double.infinity.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: MainColor.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 5.h,
            ),

            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    GlobalController.to.isStaging.value = false;
                    GlobalController.to.baseUrl = ApiConstant.production;
                  },

                  title: Text(
                    'Production',
                    style: GoogleTextStyle.fw400.copyWith(
                      color: GlobalController.to.isStaging.value == true
                          ? MainColor.black
                          : MainColor.primary,
                      fontSize: 14.sp,
                    ),
                  ),

                  trailing: (GlobalController.to.isStaging.value == true)
                      ? null
                      : Icon(
                    Icons.check,
                    color: MainColor.primary,
                    size: 14.sp,
                  ),
                ),

                Divider(height: 1.h),

                ListTile(
                  onTap: () {
                    GlobalController.to.isStaging.value = true;
                    GlobalController.to.baseUrl = ApiConstant.staging;
                  },

                  title: Text(
                    'Stagging',
                    style: GoogleTextStyle.fw400.copyWith(
                      color: GlobalController.to.isStaging.value == true
                          ? MainColor.black
                          : MainColor.primary,
                      fontSize: 14.sp,
                    ),
                  ),

                  trailing: (!GlobalController.to.isStaging.value == true)
                      ? null
                      : Icon(
                    Icons.check,
                    color: MainColor.primary,
                    size: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
