import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/home/controllers/catalog_controller.dart';

class CatalogAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Conditional.single(
      context: context,
      conditionBuilder: (context) => CatalogController.to.catalogState.value == 'success',
      widgetBuilder: (context) => AppBar(
        backgroundColor: MainColor.white,
        elevation: 2,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r)
          )
        ),
        title: Text(
          CatalogController.to.catalogData!.menu.nama,
          style: Get.textTheme.titleMedium,
        ),

        leading: IconButton(
          onPressed: () => Get.back(result: CatalogController.to.catalogData),
          icon: Icon(
            Icons.chevron_left,
            color: MainColor.black,
            size: 36.r,
          ),
        ),
      ),
      fallbackBuilder: (context) => const SizedBox(),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}