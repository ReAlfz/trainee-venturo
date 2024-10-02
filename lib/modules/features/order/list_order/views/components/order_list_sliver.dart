import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/shared/widgets/menu_card.dart';

class OrderListSliver extends StatelessWidget {
  final List<MenuModel> listMenu;
  const OrderListSliver({super.key, required this.listMenu});

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 122.h,
      delegate: SliverChildBuilderDelegate(
        childCount: listMenu.length,
        (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 8.5.h),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10.r),
            child: MenuCard(
              menu: listMenu[index],
            ),
          ),
        ),
      ),
    );
  }
}