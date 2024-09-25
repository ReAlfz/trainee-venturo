import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/chekout/quantitiy_counter.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  final VoidCallback? onTap;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const MenuCard({
    super.key,
    required this.menu,
    this.onTap,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        width: 1.sw,
        decoration: BoxDecoration(
          color: MainColor.white,
          borderRadius: BorderRadius.circular(10.r),
        ),

        child: Row(
          children: [
            Container(
              height: 90.h,
              width: 90.w,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[100],
              ),

              child: CachedNetworkImage(
                imageUrl: menu.foto,
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain,
              ),
            ),
            
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  Text(
                    'Rp. ${menu.harga.toString()}',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 75.r,
              padding: EdgeInsets.only(left: 12.r, right: 5.r),
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                child: QuantityCounter(
                  quantity: menu.jumlah,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}