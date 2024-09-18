import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/modules/features/sign_in/views/components/elevated_button_sign_in.dart';
import 'package:trainee/modules/features/sign_in/views/components/form_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 40.h),
              const ElevatedButtonComponents(title: 'Masuk'),

              SizedBox(height: 80.h),
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

              const ElevatedButtonComponents(
                title: 'Masuk menggunakan ',
                method: 'Google',
                svgIcon: ImageConstant.ic_google,
              ),
            ],
          ),
        ),
      ),
    );
  }
}