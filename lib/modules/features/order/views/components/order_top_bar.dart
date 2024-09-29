import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderTopBar extends StatelessWidget implements PreferredSizeWidget{
  const OrderTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            spreadRadius: -1,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: TabBar(
        indicatorWeight: 3.h,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey[400],
        indicatorColor: Theme.of(context).primaryColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 70.w),
        labelStyle: Get.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Sedang berjalan'),
          Tab(text: 'Riwayat'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}