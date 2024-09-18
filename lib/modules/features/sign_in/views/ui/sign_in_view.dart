import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/shared/customs/elevated_button_sign_in.dart';
import 'package:trainee/modules/features/sign_in/views/components/form_sign_in.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'Web',
      );
    }

    return Scaffold(
      extendBody: false,
      backgroundColor: MainColor.white,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onDoubleTap: () => SignInController.to.flavorSetting(),
                child: Image.asset(
                  ImageConstant.img_logo,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 121.h),
              Text(
                'Masuk untuk melanjutkan!',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40.h),
              const FormSignInCompoent(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => SignInController.to.forgetPasswordPush(),
                  child: Text(
                    "Lupa Password?",
                    style: GoogleTextStyle.fw600.copyWith(
                      fontSize: 14.sp,
                      color: MainColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 40.h),
              ElevatedButtonCustom(
                title: 'Masuk',
                text_color: MainColor.white,
                bg_color: MainColor.primary,
                function: () => SignInController.to.validateForm(context),
              ),

              SizedBox(height: 40.h),
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: MainColor.grey, endIndent: 5),
                  ),

                  Text(
                    'atau',
                    style: GoogleTextStyle.fw300.copyWith(
                      color: MainColor.grey,
                      fontSize: 12,
                    ),
                  ),

                  const Expanded(
                    child: Divider(color: MainColor.grey, indent: 5),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              ElevatedButtonCustom(
                title: 'Masuk menggunakan ',
                method: 'Google',
                svgIcon: ImageConstant.ic_google,
                bg_color: MainColor.white,
                text_color: MainColor.black,
                function: () => SignInController.to.validateForm(context),
              ),

              SizedBox(height: 10.h),

              ElevatedButtonCustom(
                title: 'Masuk menggunakan ',
                method: 'Apple',
                svgIcon: ImageConstant.ic_apple,
                bg_color: MainColor.black,
                text_color: MainColor.white,
                function: () => SignInController.to.validateForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}