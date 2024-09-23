import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';
import 'package:trainee/modules/features/list/views/components/menu_card.dart';
import 'package:trainee/modules/features/list/views/components/menu_chip.dart';
import 'package:trainee/modules/features/list/views/components/promo_card.dart';
import 'package:trainee/modules/features/list/views/components/search_app_bar.dart';
import 'package:trainee/modules/features/list/views/components/section_header.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<IconData> categoryIcon = [
      Icons.list_alt_outlined,
      Icons.fastfood_outlined,
      Icons.coffee_outlined,
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: SearchAppBar(onChange: (value) => ListController.to.keyword(value)),
        body: NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(child: 22.verticalSpace),
              const SliverToBoxAdapter(
                child: SectionHeader(
                  icon: Icons.note_alt_outlined,
                  title: 'Available promo',
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
                    itemCount: ListController.to.promoList.length,
                    separatorBuilder: (context, index) => 26.horizontalSpace,
                    itemBuilder: (context, index) {
                      final promo = ListController.to.promoList[index];
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
                    itemCount: ListController.to.categories.length,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      final category = ListController.to.categories[index];
                      return Obx(() => MenuChip(
                        onTap: () => ListController.to.selectCategory(category.toLowerCase()),
                        isSelected: ListController.to.selectCategory.value == category.toLowerCase(),
                        iconData: categoryIcon[index],
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
                final currentCategory = ListController.to.selectCategory.value;
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
                            : 'Minuman',

                    icon: (currentCategory == 'semua')
                        ? Icons.menu_book
                        : (currentCategory == 'minuman')
                            ? Icons.food_bank
                            : Icons.local_drink,
                  ),
                );
              }),

              Expanded(
                child: Obx(() => SmartRefresher(
                  controller: ListController.to.refreshController,
                  onRefresh: ListController.to.onRefresh,
                  onLoading: ListController.to.getListOfData,
                  enablePullUp: ListController.to.canLoadMore.isTrue ? true : false,
                  enablePullDown: true,
                  child: ListView.builder(
                    itemCount: ListController.to.filteredList.length,
                    itemExtent: 122.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      final menuItem = ListController.to.filteredList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.5.h),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              Obx(() => SlidableAction(
                                onPressed: (context) => ListController.to.deleteItem(menuItem),
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(10.r)
                                ),
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: MainColor.white,
                                icon: Icons.delete,
                                label: 'delete',
                              )),
                            ],
                          ),

                          child: Material(
                            borderRadius: BorderRadius.circular(10.r),
                            elevation: 2,
                            child: MenuCard(
                              menu: menuItem,
                              onTap: () => ListController.to.pushPage(menuItem.idMenu),
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

        // bottomNavigationBar: ,
      ),
    );
  }
}