import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/catalog/controllers/catalog_controller.dart';
import 'package:trainee/modules/features/catalog/views/components/catalog_appbar.dart';
import 'package:trainee/modules/features/error_handler/views/ui/NoDataView.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CatalogAppBar(
          title: CatalogController.to.menuItem.value!.nama,
          onTap: () => CatalogController.to.popPage(),
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 240.h,
                width: 240.w,
                child: Image.network(
                  CatalogController.to.menuItem.value!.foto,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Container(
              
            ),
          ],
        ),
      ),
    );
  }
}