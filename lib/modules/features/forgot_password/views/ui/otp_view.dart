import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/forgot_password/controllers/otp_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      analytics.setCurrentScreen(
        screenName: 'OTP Screen',
        screenClassOverride: 'Web',
      );
    }

    return Scaffold(
      backgroundColor: MainColor.white,
      body: Container(
        padding: EdgeInsets.all(32.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstant.img_logo,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 121.h),
              Obx(() => Text(
                'Masukkan kode otp yang telah dikirim ke email ${OtpController.to.email.value}',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              )),

              SizedBox(height: 40.h),
              Pinput(
                controller: OtpController.to.otpTextController,
                length: 4,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onCompleted: OtpController.to.onOtpComplete,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != '1234') {
                    return "Kode opt salah";
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}