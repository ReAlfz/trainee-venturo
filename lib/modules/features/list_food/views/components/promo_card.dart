import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/list_food/modules/promo_item_model.dart';

class PromoCard extends StatelessWidget {
  final bool? enableShadow;
  final PromoModel promo;
  final double? witdh;

  const PromoCard({
    super.key, this.enableShadow,
    required this.promo,
    this.witdh
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: witdh ?? 282.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
            image: CachedNetworkImageProvider(promo.foto),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withAlpha(150),
              BlendMode.srcATop,
            ),
          ),

          boxShadow: [
            if (enableShadow == true) const BoxShadow(
              color: Color.fromARGB(115, 71, 70, 70),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),

        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                softWrap: true,
                textAlign: TextAlign.center,
                TextSpan(
                  text: promo.type,
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: MainColor.white,
                  ),

                  children: [
                    if (promo.type == 'diskon') TextSpan(
                      text: ' ${promo.nominal}%',
                      style: Get.textTheme.displaySmall?.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = MainColor.white,
                      ),
                    ),
                  ],
                ),
              ),

              if (promo.type == 'voucher') Text(
                ' Rp.${promo.nominal}',
                style: Get.textTheme.displaySmall?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = MainColor.white,
                ),
              ),
              
              Text(
                promo.nama,
                textAlign: TextAlign.center,
                style: Get.textTheme.labelMedium?.copyWith(
                  color: MainColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}