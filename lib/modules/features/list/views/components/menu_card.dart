import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/list/modules/menu_item_model.dart';

class MenuCard extends StatelessWidget {
  final MenuItems menu;
  final bool isSelected;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.menu,
    required this.isSelected,
    this.onTap
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
          border: Border.all(
            color: (isSelected)
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
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
                imageUrl: menu.foto ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
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
                    menu.harga.toString(),
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}