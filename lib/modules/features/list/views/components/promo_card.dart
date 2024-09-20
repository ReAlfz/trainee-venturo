import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';

class PromoCard extends StatelessWidget {
  final bool? enableShadow;
  final String promoName;
  final String discountNominal;
  final String thumbnailUrl;
  final double? witdh;

  const PromoCard({super.key, this.enableShadow, required this.promoName, required this.discountNominal, required this.thumbnailUrl, this.witdh});

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
            image: CachedNetworkImageProvider(thumbnailUrl),
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
                  text: 'Diskon',
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: MainColor.white,
                  ),

                  children: [
                    TextSpan(
                      text: '$discountNominal %',
                      style: Get.textTheme.displaySmall?.copyWith(
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
              
              Text(
                promoName,
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