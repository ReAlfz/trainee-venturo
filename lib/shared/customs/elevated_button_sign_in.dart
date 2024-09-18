import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String title;
  final Color text_color;
  final Color bg_color;
  final String? method;
  final String? svgIcon;
  final VoidCallback function;

  const ElevatedButtonCustom({
    super.key,
    required this.title,
    this.method,
    this.svgIcon,
    required this.bg_color,
    required this.text_color,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: EvelatedButtonStyle.mainRounded(bg_color: bg_color),
      onPressed: function,
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
                color: text_color,
                fontSize: 14.sp,
              ),
              children: [
                TextSpan(
                  text: method,
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: text_color
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
          color: text_color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
