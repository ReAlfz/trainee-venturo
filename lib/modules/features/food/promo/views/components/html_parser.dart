import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HtmlParser extends StatelessWidget {
  final String htmlData;

  const HtmlParser({super.key, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    final String filterString = htmlData.replaceAll(RegExp(r'<[^>]*>'), '');
    return Text(
      filterString,
      softWrap: true,
      maxLines: 6,
      overflow: TextOverflow.visible,
      style: Get.textTheme.bodySmall!.copyWith(
        fontSize: 13.sp,
      ),
    );
  }
}
