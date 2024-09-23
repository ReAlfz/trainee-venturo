import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/modules/features/home/views/components/menu_card.dart';

class CartListSliver extends StatelessWidget {
  final List<Map<String, dynamic>> carts;
  const CartListSliver({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 112.h,
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.5.h),
          child: MenuCard(
            menu: carts[index]['item'],
          ),
        );


        }, childCount: carts.length,
      ),
    );
  }
}