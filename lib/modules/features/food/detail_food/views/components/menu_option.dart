import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';

class MenuOptions extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double width;
  final VoidCallback onTap;
  const MenuOptions({super.key, required this.text, required this.isSelected, required this.width, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 1.5.h,
        ),
        width: (isSelected) ? width * 1.75 : width,
        decoration: BoxDecoration(
          color: (isSelected) ? MainColor.primary : null,
          borderRadius: BorderRadius.circular(30.r),
          border: (!isSelected) ? Border.all(
            color: MainColor.primary,
            width: 1.5.r,
          ) : null,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Get.textTheme.bodyMedium!.copyWith(
                color: (isSelected)
                    ? MainColor.white
                    : MainColor.black,
              ),
            ),

            if (isSelected)...[
              2.5.horizontalSpace,
              const Icon(
                Icons.check,
                color: MainColor.white,
                size: 15,
              ),
            ]
          ],
        ),
      ),
    );
  }
}