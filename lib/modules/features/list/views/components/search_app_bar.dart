import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onChange;

  const SearchAppBar({super.key, this.searchController, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.h,
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: MainColor.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
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

      child: TextField(
        controller: searchController,
        onChanged: onChange,
        style: Get.textTheme.labelSmall?.copyWith(
          fontSize: 18.sp,
          letterSpacing: 0,
        ),

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),

          prefixIcon: Icon(
            Icons.search,
            size: 26.h,
          ),

          prefixIconColor: Theme.of(context).primaryColor,
          hintText: 'Search'.tr,
          hintStyle: Get.textTheme.labelSmall?.copyWith(
            color: Colors.black87,
            fontSize: 14.sp,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}