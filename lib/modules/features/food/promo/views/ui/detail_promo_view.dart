import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/food/promo/controllers/detail_promo_controller.dart';
import 'package:trainee/shared/widgets/rounded_custom_appbar.dart';

class DetailPromoView extends StatelessWidget {
  const DetailPromoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: RoundedAppBar(
          title: 'Promo'.tr,
          svgPicture: ImageConstant.ic_promo,
          onBackPressed: DetailPromoController.to.backPromo,
          enableBackButton: true,
        ),
        body: Column(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}