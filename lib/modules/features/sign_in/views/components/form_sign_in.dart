import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/shared/customs/text_form_field_custom.dart';

class FormSignInCompoent extends StatelessWidget {
  const FormSignInCompoent({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SignInController.to.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormFieldCustoms(
            label: 'Email Address'.tr,
            hint: 'Input Email address'.tr,
            isRequired: true,
            requiredText: 'Email address cannot be empty'.tr,
            initialValue: SignInController.to.emailValue.value,
            controller: SignInController.to.emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(
            height: 40.h,
          ),

          Obx(() => TextFormFieldCustoms(
            label: 'Password'.tr,
            hint: 'Input Password'.tr,
            isRequired: true,
            controller: SignInController.to.passwordCtrl,
            keyboardType: TextInputType.visiblePassword,
            initialValue: SignInController.to.passwordValue.value,
            isPassword: SignInController.to.isPassword.value,
            requiredText: 'Password cannot be empty'.tr,
            suffixIcon: GestureDetector(
              onTap: () => SignInController.to.showPassword(),
              child: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  (SignInController.to.isPassword.value)
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 16,
                  color: MainColor.grey,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}