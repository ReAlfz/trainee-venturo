import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ElevatedButtonComponents extends StatelessWidget {
  final String title;
  final String? method;
  final String? svgIcon;

  const ElevatedButtonComponents({
    super.key,
    required this.title,
    this.method,
    this.svgIcon
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: EvelatedButtonStyle.mainRounded,
      onPressed: () => SignInController.to.validateForm(context),
      child: (method != null)
          ? Row(
        children: [
          SvgPicture.asset(
            svgIcon!,
          ),
          SizedBox(width: 10.h),
          RichText(
            text: TextSpan(
              text: title,
              style: GoogleTextStyle.fw400.copyWith(
                color: MainColor.black,
                fontSize: 14.sp,
              ),
              children: [
                TextSpan(
                  text: method,
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : Text(
        title,
        style: GoogleTextStyle.fw800.copyWith(
          fontSize: 14.sp,
          color: MainColor.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
