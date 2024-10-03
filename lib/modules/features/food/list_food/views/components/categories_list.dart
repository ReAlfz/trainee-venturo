import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../../../configs/themes/main_color.dart';
import '../../../../../../shared/widgets/menu_card.dart';
import '../../../../chekout/controllers/checkout_controller.dart';
import '../../controller/list_food_controller.dart';
import 'list_food_shimmer.dart';

class CategoriesList extends StatelessWidget {
  final String? condition;
  final double itemExtent;
  final double horizontalSliverPadding;

  const CategoriesList(
      {super.key,
      required this.itemExtent,
      required this.horizontalSliverPadding,
      this.condition});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final currentList = (condition == null)
            ? ListFoodController.to.filteredList
            : ListFoodController.to.filteredList
                .where((element) => element.kategori == condition).toList();
        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontalSliverPadding),
          sliver: SliverFixedExtentList(
            itemExtent: itemExtent,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final menuItem = currentList[index];
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
                        child: (ListFoodController.to.listFoodState.value ==
                                'success')
                            ? MenuCard(
                                menu: menuItem,
                                onTap: () =>
                                    ListFoodController.to.pushPage(menuItem),
                                onIncrement: () {
                                  cartController.increaseQty(menuItem);
                                  ListFoodController.to.listMenu.refresh();
                                },
                                onDecrement: () {
                                  cartController.decreaseQty(menuItem);
                                  ListFoodController.to.listMenu.refresh();
                                },
                              )
                            : const ListFoodShimmer(),
                      ),
                    ),
                  ),
                );
              },
              childCount: currentList.length,
            ),
          ),
        );
      },
    );
  }
}
