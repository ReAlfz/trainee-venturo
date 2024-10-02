import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

class FabCheckout extends StatelessWidget {
  const FabCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: HomeController.to.pushCheckout,
      elevation: 10,
      backgroundColor: MainColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(
        Icons.shopping_cart,
        color: MainColor.primary,
        size: 25.r,
      ),
    );
  }
}