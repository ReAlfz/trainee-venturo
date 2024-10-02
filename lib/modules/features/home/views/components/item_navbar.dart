import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

import '../../../../../configs/themes/main_color.dart';

class ItemNavbar extends StatelessWidget {
  final VoidCallback onTap;
  final Widget svgIcon;
  final String title;
  final int checkIndex;

  const ItemNavbar({
    super.key,
    required this.onTap,
    required this.svgIcon,
    required this.title,
    required this.checkIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgIcon,
            2.verticalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: (HomeController.to.currentIndex.value == checkIndex)
                    ? MainColor.white : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
