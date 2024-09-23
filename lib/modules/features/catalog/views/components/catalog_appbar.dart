import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback onTap;
  const CatalogAppBar({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: MainColor.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.r),
        ),

        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(111, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),

          Text(title,),

          const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}