import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';
import 'package:trainee/shared/widgets/menu_card.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class CartListSliver extends StatelessWidget {
  final List<MenuModel> cart;
  const CartListSliver({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 122.h,
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.5.h),
          child: MenuCard(
            menu: cart[index],
            onIncrement: () => CheckoutController.to.increaseQty(cart[index]),
            onDecrement: () => CheckoutController.to.decreaseQty(cart[index]),
          ),
        );
      }, childCount: cart.length),
    );
  }
}