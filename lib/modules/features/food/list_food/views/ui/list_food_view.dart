import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/food/list_food/views/components/categories_list.dart';
import 'package:trainee/modules/features/home/views/components/fab_checkout.dart';

import '../../controller/list_food_controller.dart';
import '../components/menu_chip.dart';
import '../components/promo_card.dart';
import '../components/search_app_bar.dart';
import '../components/section_header.dart';

class ListFoodView extends StatelessWidget {
  const ListFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(
        onChange: (value) => ListFoodController.to.keyword(value),
      ),
      floatingActionButton: const FabCheckout(),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(child: 22.verticalSpace),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Promo Available'.tr,
                svgIcon: ImageConstant.ic_promo,
                widthSvg: 17.5.r,
                heightSvg: 17.5.r,
              ),
            ),

            // Promo card //
            SliverToBoxAdapter(child: 22.verticalSpace),
            SliverToBoxAdapter(
              child: Obx(
                () => SizedBox(
                  width: 1.sw,
                  height: 188.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemCount: ListFoodController.to.promoList.length,
                    separatorBuilder: (context, index) => 26.horizontalSpace,
                    itemBuilder: (context, index) {
                      final promo = ListFoodController.to.promoList[index];
                      return PromoCard(
                        enableShadow: false,
                        onTap: () => ListFoodController.to.pushPromo(index: index),
                        promo: promo,
                        witdh: 300.w,
                      );
                    },
                  ),
                ),
              ),
            ),

            // row of categories
            SliverToBoxAdapter(child: 22.verticalSpace),
            SliverToBoxAdapter(
              child: SizedBox(
                width: 1.sw,
                height: 45.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ListFoodController.to.categories.length,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemBuilder: (context, index) {
                    final category = ListFoodController.to.categories[index];
                    return Obx(
                      () => MenuChip(
                        onTap: () => ListFoodController.to
                            .selectCategory(category.toLowerCase()),
                        isSelected:
                            ListFoodController.to.selectCategory.value ==
                                category.toLowerCase(),
                        frontIcon: ListFoodController.to.categoryIcon[index],
                        text: category.tr,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 13.horizontalSpace,
                ),
              ),
            ),
            SliverToBoxAdapter(child: 10.verticalSpace),
          ];
        },
        body: Obx(() {
          return SmartRefresher(
            controller: ListFoodController.to.refreshController,
            onRefresh: ListFoodController.to.onRefresh,
            onLoading: ListFoodController.to.onLoading,
            enablePullUp:
                ListFoodController.to.canLoadMore.isTrue ? true : false,
            enablePullDown: true,
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: 15.verticalSpace),
                if (ListFoodController.to.selectCategory.value != 'semua') ...[
                  SliverToBoxAdapter(
                    child: ConditionalSwitch.single(
                      context: context,
                      valueBuilder: (context) =>
                          ListFoodController.to.selectCategory.value,
                      caseBuilders: {
                        'minuman': (context) => SectionHeader(
                              title: ListFoodController.to.categories[2],
                              icon: Icons.local_drink,
                            ),
                        'snack': (context) => SectionHeader(
                              title: ListFoodController.to.categories[3],
                              icon: Icons.no_food_outlined,
                            ),
                      },
                      fallbackBuilder: (context) => SectionHeader(
                        title: ListFoodController.to.categories[1],
                        icon: Icons.food_bank,
                      ),
                    ),
                  ),
                  CategoriesList(
                    itemExtent: 122.h,
                    horizontalSliverPadding: 20.w,
                  ),
                ],
                if (ListFoodController.to.selectCategory.value == 'semua') ...[
                  if (ListFoodController.to.filteredList
                      .where((element) => element.kategori == 'makanan')
                      .toList()
                      .isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SectionHeader(
                        title: ListFoodController.to.categories[1],
                        icon: Icons.food_bank,
                      ),
                    ),
                    CategoriesList(
                      itemExtent: 122.h,
                      horizontalSliverPadding: 20.w,
                      condition: 'makanan',
                    ),
                    SliverToBoxAdapter(child: 20.verticalSpace),
                  ],

                  if (ListFoodController.to.filteredList
                      .where((element) => element.kategori == 'minuman')
                      .toList()
                      .isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SectionHeader(
                        title: ListFoodController.to.categories[2],
                        icon: Icons.local_drink,
                      ),
                    ),
                    CategoriesList(
                      itemExtent: 122.h,
                      horizontalSliverPadding: 20.w,
                      condition: 'minuman',
                    ),
                    SliverToBoxAdapter(child: 20.verticalSpace),
                  ],

                  if (ListFoodController.to.filteredList.where((element) => element.kategori == 'snack').toList().isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SectionHeader(
                        title: ListFoodController.to.categories[3],
                        icon: Icons.no_food_outlined,
                      ),
                    ),
                    CategoriesList(
                      itemExtent: 122.h,
                      horizontalSliverPadding: 20.w,
                      condition: 'snack',
                    ),
                  ]
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}
