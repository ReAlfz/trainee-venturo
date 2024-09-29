import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/list_food/controllers/list_food_controller.dart';
import 'package:trainee/modules/features/list_food/views/components/menu_chip.dart';
import 'package:trainee/modules/features/list_food/views/components/promo_card.dart';
import 'package:trainee/modules/features/list_food/views/components/search_app_bar.dart';
import 'package:trainee/modules/features/list_food/views/components/section_header.dart';
import 'package:trainee/shared/widgets/menu_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListFoodView extends StatelessWidget {
  const ListFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        onChange: (value) => ListFoodController.to.keyword(value),
      ),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(child: 22.verticalSpace),
            const SliverToBoxAdapter(
              child: SectionHeader(
                icon: Icons.note_alt_outlined,
                title: 'Promo yang tersedia',
              ),
            ),

            // Promo card //
            SliverToBoxAdapter(child: 22.verticalSpace),
            SliverToBoxAdapter(
                child: Obx(() => SizedBox(
                  width: 1.sw,
                  height: 188.h,
                  child: ListView.separated(
                    shrinkWrap: true,
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
                ))
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
                    return Obx(() => MenuChip(
                      onTap: () => ListFoodController.to.selectCategory(category.toLowerCase()),
                      isSelected: ListFoodController.to.selectCategory.value == category.toLowerCase(),
                      iconData: ListFoodController.to.categoryIcon[index],
                      text: category,
                    ));
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
              final currentCategory = ListFoodController.to.selectCategory.value;
              return Container(
                width: 1.sw,
                height: 35.h,
                color: Colors.grey[100],
                margin: EdgeInsets.only(bottom: 10.h),
                child: SectionHeader(
                  title: (currentCategory == 'semua')
                      ? 'Semua Menu'
                      : (currentCategory == 'makanan')
                      ? 'Makanan'
                      : (currentCategory == 'minuman')
                      ? 'Minuman' : 'Snack',

                  icon: (currentCategory == 'semua')
                      ? Icons.menu_book
                      : (currentCategory == 'makanan')
                      ? Icons.food_bank
                      : (currentCategory == 'minuman')
                      ? Icons.local_drink : Icons.no_food_outlined,
                ),
              );
            }),

            Expanded(
              child: Obx(() => SmartRefresher(
                controller: ListFoodController.to.refreshController,
                onRefresh: ListFoodController.to.onRefresh,
                onLoading: ListFoodController.to.onLoading,
                enablePullUp: ListFoodController.to.canLoadMore.isTrue ? true : false,
                enablePullDown: true,
                child: ListView.builder(
                  itemCount: ListFoodController.to.filteredList.length,
                  itemExtent: 122.h,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemBuilder: (context, index) {
                    final menuItem = ListFoodController.to.filteredList[index];
                    final cartController = Get.put(CheckoutController());
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.5.h),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => ListFoodController.to.deleteItem(menuItem),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10.r)
                              ),
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: MainColor.white,
                              icon: Icons.delete,
                              label: 'delete',
                            ),
                          ],
                        ),

                        child: Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 2,
                          child: MenuCard(
                            menu: menuItem,
                            onTap: () => ListFoodController.to.pushPage(menuItem),
                            onIncrement: () {
                              cartController.increaseQty(menuItem);
                              ListFoodController.to.listMenu.refresh();
                            },
                            onDecrement: () {
                              cartController.decreaseQty(menuItem);
                              ListFoodController.to.listMenu.refresh();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}