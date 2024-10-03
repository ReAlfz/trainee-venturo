import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/profile/controllers/profile_controller.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/shared/customs/elevated_button_sign_in.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';
import 'package:trainee/shared/widgets/tile_option.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GlobalController.to.user.value!;
    return Scaffold(
      appBar: RoundedAppBar(
        title: 'Profile'.tr,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bg_blank_connection),
            alignment: Alignment.center,
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            Center(
              child: Container(
                width: 170.r,
                height: 170.r,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  children: [
                    Obx(
                      () => Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            ProfileController.to.imageFile != null,
                        widgetBuilder: (context) => Image.file(
                          ProfileController.to.imageFile!,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        ),
                        fallbackBuilder: (context) => Image.asset(
                          ImageConstant.bg_profile,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: MainColor.primary,
                        child: InkWell(
                          onTap: ProfileController.to.pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                            child: Text(
                              'Change'.tr,
                              textAlign: TextAlign.center,
                              style: Get.textTheme.labelMedium!.copyWith(
                                color: MainColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            21.verticalSpacingRadius,
            Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    ProfileController.to.isVerify.value != false,
                widgetBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 20.r,
                    ),
                    7.horizontalSpaceRadius,
                    Text(
                      'Your have verified your ID card'.tr,
                      style: Get.textTheme.labelMedium!.copyWith(
                        color: MainColor.blueColor,
                      ),
                    ),
                  ],
                ),
                fallbackBuilder: (context) => InkWell(
                  onTap: ProfileController.to.pickFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstant.ic_ktp),
                      7.horizontalSpaceRadius,
                      Text(
                        'Verify your ID card now!'.tr,
                        style: Get.textTheme.labelMedium!.copyWith(
                          color: MainColor.blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            18.verticalSpacingRadius,
            Padding(
              padding: EdgeInsets.only(left: 20.r),
              child: Text(
                'Account info'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: MainColor.blueColor,
                ),
              ),
            ),
            14.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.r, vertical: 30.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: MainColor.lightColor2,
              ),
              child: Column(
                children: [
                  TileOption(title: 'Name'.tr, message: user.nama),
                  const Divider(thickness: 0.5),
                  TileOption(title: 'Birth date'.tr, message: "01/02/2003"),
                  const Divider(thickness: 0.5),
                  TileOption(title: 'Phone number'.tr, message: "088888888888"),
                  const Divider(thickness: 0.5),
                  TileOption(title: 'Email'.tr, message: user.email),
                  const Divider(thickness: 0.5),
                  TileOption(title: 'Change PIN'.tr, message: "******"),
                  const Divider(thickness: 0.5),
                  Obx(
                    () => TileOption(
                      title: 'Change language'.tr,
                      message: ProfileController.to.currentLang.value,
                      onTap: ProfileController.to.updateLanguage,
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.r, vertical: 14.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: MainColor.lightColor2,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageConstant.ic_review),
                            9.horizontalSpaceRadius,
                            Text(
                              'Rating'.tr,
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColor.primary,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: MainColor.white, width: 1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text("Rate Now".tr),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            27.verticalSpacingRadius,
            Padding(
              padding: EdgeInsets.only(left: 20.r),
              child: Text(
                'Other info'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: MainColor.blueColor,
                ),
              ),
            ),
            14.verticalSpacingRadius,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: MainColor.lightColor2,
              ),
              child: Column(
                children: [
                  Obx(
                    () => TileOption(
                      title: 'Device Info'.tr,
                      message: ProfileController.to.deviceModel.value,
                    ),
                  ),
                  const Divider(thickness: 0.5),
                  Obx(
                    () => TileOption(
                      title: 'Device Version'.tr,
                      message: ProfileController.to.deviceVersion.value,
                    ),
                  )
                ],
              ),
            ),
            15.verticalSpacingRadius,
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
              color: MainColor.lightColor2,
              child: ElevatedButtonCustom(
                title: 'Logout'.tr,
                bg_color: MainColor.primary,
                text_color: MainColor.white,
                widthButton: 200.w,
                heightButton: 40.h,
                function: ProfileController.to.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
