import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListOrderShimmer extends StatelessWidget {
  const ListOrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey[400]!,
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: Colors.black87,
            ),
          ],
        ),

        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: 124.w,
                  padding: EdgeInsets.all(10.r),
                  constraints: BoxConstraints(
                    minHeight: 124.h,
                    maxWidth: 124.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey[300],
                  ),
                ),
              ),

              12.horizontalSpace,

              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.verticalSpace,

                    Container(height: 10),

                    14.verticalSpace,

                    Text(''),

                    5.verticalSpace,

                    Row(
                      children: [
                        Text(''),
                        5.horizontalSpace,
                        Text(''),
                      ],
                    ),
                  ],
                ),
              ),

              5.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
