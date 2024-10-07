import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trainee/modules/features/food/detail_food/views/components/detail_food_shimmer.dart';

import '../../../../../../shared/widgets/rounded_custom_appbar.dart';
import '../../controllers/detail_food_controller.dart';
import '../components/detail_food_body.dart';

class DetailFoodView extends StatelessWidget {
  const DetailFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: RoundedAppBar(
          title: 'Detail Menu',
          enableBackButton: true,
          onBackPressed: DetailFoodController.to.updateData,
        ),
        body: SizedBox(
          height: 1.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Obx(
                      () => Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                    DetailFoodController.to.catalogState.value == 'success',
                    widgetBuilder: (context) => CachedNetworkImage(
                      imageUrl:
                      DetailFoodController.to.catalogData.value!.menu.foto,
                      height: 1.sh,
                      fit: BoxFit.fitHeight,
                      errorWidget: (context, url, error) {
                        return CachedNetworkImage(
                          imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                          height: 1.sh,
                          fit: BoxFit.fitHeight,
                        );
                      },
                    ),
                    fallbackBuilder: (context) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey[400]!,
                      child: Container(
                        height: 1.sh,
                        width: 250.w,
                        margin: EdgeInsets.symmetric(vertical: 10.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, -2),
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Obx(
                        () => Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        DetailFoodController.to.catalogState.value ==
                            'success',
                        widgetBuilder: (context) {
                          final food = DetailFoodController.to.catalogData.value!;
                          return DetailFoodBody(food: food);
                        },
                        fallbackBuilder: (context) => const DetailFoodShimmer()
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
