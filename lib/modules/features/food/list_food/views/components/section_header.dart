import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color? color;
  final String? svgIcon;
  final IconData? icon;

  const SectionHeader({super.key, required this.title, this.color, this.icon, this.svgIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 28.r,
              color: color ?? Theme.of(context).primaryColor,
            ),

          if (svgIcon != null)
            SvgPicture.asset(
              svgIcon!,
              height: 28.r,
              width: 28.r,
            ),

          10.horizontalSpace,
          
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              color: color,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}