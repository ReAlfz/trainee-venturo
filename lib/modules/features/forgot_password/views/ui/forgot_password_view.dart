import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/forgot_password/controllers/forget_password_controller.dart';
import 'package:trainee/shared/customs/elevated_button_sign_in.dart';
import 'package:trainee/shared/customs/text_form_field_custom.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: MainColor.white,
      body: Container(
        padding: const EdgeInsets.all(45),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                child: Image.asset(
                  ImageConstant.img_logo,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 121.h),
              Text(
                'Masukkan alamat email untuk mengubah password anda',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20.h),
              Form(
                key: ForgotPasswordController.to.formKey,
                child: TextFormFieldCustoms(
                  label: 'Email Address',
                  hint: 'Input Email Address',
                  isRequired: true,
                  initialValue: ForgotPasswordController.to.emailValue.value,
                  controller: ForgotPasswordController.to.emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  requiredText: 'Email address cannot be empty',
                ),
              ),

              SizedBox(height: 40.h),
              ElevatedButtonCustom(
                title: 'Ubah Password',
                bg_color: MainColor.primary,
                text_color: MainColor.white,
                function: () => ForgotPasswordController.to.otpPush(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}