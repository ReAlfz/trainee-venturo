import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';

class MenuChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final IconData iconData;
  final VoidCallback? onTap;

  const MenuChip({super.key, required this.isSelected, required this.text, this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? MainColor.black : MainColor.primary,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: Colors.black54,
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 20,
                color: MainColor.white,
              ),

              SizedBox(width: 5.w),

              Text(
                text,
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: MainColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}