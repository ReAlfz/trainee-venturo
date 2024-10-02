import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DetailFoodShimmer extends StatelessWidget {
  const DetailFoodShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var heightTileOption = 50.h;
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey[400]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100.h,
            margin: EdgeInsets.only(top: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          15.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: heightTileOption,
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              const Divider(
                  thickness: 0.2, color: Colors.transparent, height: 1),
              Container(
                height: heightTileOption,
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              const Divider(
                  thickness: 0.2, color: Colors.transparent, height: 1),
              Container(
                height: heightTileOption,
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              const Divider(
                  thickness: 0.2, color: Colors.transparent, height: 1),
              Container(
                height: heightTileOption,
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              const Divider(
                  thickness: 0.2, color: Colors.transparent, height: 1),
            ],
          ),
          40.verticalSpacingRadius,
          Container(
            width: 1.sw,
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ],
      ),
    );
  }
}
