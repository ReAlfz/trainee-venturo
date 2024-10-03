import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonStyle {
  static mainRounded({
    required Color bg_color,
    double? width, height
  }) {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(
        Size(width ?? double.infinity, height ?? 50),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(144.r),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        bg_color,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        bg_color,
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 24.w,
        ),
      ),
    );
  }
}
