import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/food/list_food/views/components/list_food_shimmer.dart';
import 'package:trainee/modules/features/home/views/components/fab_checkout.dart';
import 'package:trainee/shared/widgets/menu_card.dart';

import '../../../../chekout/controllers/checkout_controller.dart';
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
                icon: Icons.note_alt_outlined,
                title: 'Promo Available'.tr,
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final currentCategory =
                  ListFoodController.to.selectCategory.value;
              late String title;
              late IconData icon;
              switch (currentCategory) {
                case 'makanan':
                  title = 'Makanan'.tr;
                  icon = Icons.food_bank;
                  break;

                case 'minuman':
                  title = 'Minuman'.tr;
                  icon = Icons.local_drink;
                  break;

                case 'snack':
                  title = 'Snack'.tr;
                  icon = Icons.no_food_outlined;
                  break;

                default:
                  title = 'Semua Menu'.tr;
                  icon = Icons.menu_book;
              }

              return Container(
                width: 1.sw,
                height: 35.h,
                color: Colors.grey[100],
                margin: EdgeInsets.only(bottom: 10.h),
                child: SectionHeader(
                  title: title,
                  icon: icon,
                ),
              );
            }),
            Expanded(
              child: Obx(
                () => SmartRefresher(
                  controller: ListFoodController.to.refreshController,
                  onRefresh: ListFoodController.to.onRefresh,
                  onLoading: ListFoodController.to.onLoading,
                  enablePullUp:
                      ListFoodController.to.canLoadMore.isTrue ? true : false,
                  enablePullDown: true,
                  child: ListView.builder(
                    itemCount: ListFoodController.to.filteredList.length,
                    itemExtent: 122.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      final menuItem =
                          ListFoodController.to.filteredList[index];
                      final cartController = Get.put(CheckoutController());
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.5.h),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) =>
                                    ListFoodController.to.deleteItem(menuItem),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10.r),
                                ),
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: MainColor.white,
                                icon: Icons.delete,
                                label: 'delete',
                              ),
                            ],
                          ),
                          child: Obx(
                            () => Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10.r),
                              child: (ListFoodController
                                          .to.listFoodState.value ==
                                      'success')
                                  ? MenuCard(
                                      menu: menuItem,
                                      onTap: () => ListFoodController.to
                                          .pushPage(menuItem),
                                      onIncrement: () {
                                        cartController.increaseQty(menuItem);
                                        ListFoodController.to.listMenu
                                            .refresh();
                                      },
                                      onDecrement: () {
                                        cartController.decreaseQty(menuItem);
                                        ListFoodController.to.listMenu
                                            .refresh();
                                      },
                                    )
                                  : const ListFoodShimmer(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
