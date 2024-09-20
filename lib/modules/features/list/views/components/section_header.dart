import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color? color;
  final IconData? icon;

  const SectionHeader({super.key, required this.title, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 28.r,
            color: color ?? Theme.of(context).primaryColor,
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