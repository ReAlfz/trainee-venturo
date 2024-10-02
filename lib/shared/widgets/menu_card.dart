import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/shared/widgets/quantitiy_counter.dart';

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
                errorWidget: (context, url, error) {
                  return CachedNetworkImage(
                    imageUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                    useOldImageOnUrlChange: true,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 7.5.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 7,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu.nama,
                              style: Get.textTheme.titleMedium!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            5.verticalSpace,
                            Text(
                              'Rp ${menu.harga.toString()}',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageConstant.ic_catatan,
                            fit: BoxFit.cover,
                          ),
                          2.5.horizontalSpaceRadius,
                          Expanded(
                            child: Text(
                              (menu.catatan != '')
                                  ? menu.catatan
                                  : 'tambahkan catatan',
                              style: Get.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
            )
          ],
        ),
      ),
    );
  }
}
