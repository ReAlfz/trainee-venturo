import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/food/detail_food/bindings/detail_food_bindding.dart';
import 'package:trainee/modules/features/food/detail_food/views/ui/detail_food_view.dart';
import 'package:trainee/modules/features/food/list_food/bindings/list_food_binding.dart';
import 'package:trainee/modules/features/food/list_food/views/ui/list_food_view.dart';
import 'package:trainee/modules/features/food/promo/bindings/detail_promo_binding.dart';
import 'package:trainee/modules/features/food/promo/views/ui/detail_promo_view.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';
import 'package:trainee/modules/features/home/views/components/bottom_navbar.dart';
import 'package:trainee/modules/features/order/detail_order/bindings/detail_order_binding.dart';
import 'package:trainee/modules/features/order/detail_order/views/ui/detail_order_view.dart';
import 'package:trainee/modules/features/order/list_order/bindings/order_binding.dart';
import 'package:trainee/modules/features/order/list_order/views/ui/order_view.dart';
import 'package:trainee/modules/features/profile/views/ui/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: HomeController.to.currentIndex.value,
                children: [
                  Navigator(
                    key: HomeController.to.foodKey,
                    initialRoute: MainRoute.food,
                    onGenerateRoute: (settings) {
                      Get.routing.args = settings.arguments;
                      switch (settings.name) {
                        case MainRoute.food:
                          return GetPageRoute(
                            routeName: MainRoute.food,
                            page: () => const ListFoodView(),
                            binding: ListFoodBindings(),
                            settings: settings,
                          );

                        case MainRoute.foodDetail:
                            return GetPageRoute(
                              routeName: MainRoute.foodDetail,
                              page: () => const DetailFoodView(),
                              binding: DetailFoodBinding(),
                              settings: settings,
                            );

                        case MainRoute.promo:
                          return GetPageRoute(
                            routeName: MainRoute.promo,
                            page: () => const DetailPromoView(),
                            binding: DetailPromoBinding(),
                            settings: settings,
                          );

                        default:
                          return null;
                      }
                    },
                  ),

                  Navigator(
                    key: HomeController.to.orderKey,
                    initialRoute: MainRoute.order,
                    onGenerateRoute: (settings) {
                      Get.routing.args = settings.arguments;
                      switch (settings.name) {
                        case MainRoute.order:
                          return GetPageRoute(
                            routeName: MainRoute.order,
                            page: () => const OrderView(),
                            binding: OrderBinding(),
                            settings: settings,
                          );

                        case MainRoute.orderDetail:
                          return GetPageRoute(
                            routeName: MainRoute.foodDetail,
                            page: () => const DetailOrderView(),
                            binding: DetailOrderBinding(),
                            settings: settings,
                          );

                        default:
                          return null;
                      }
                    },
                  ),

                  const ProfileView(),
                ],
              ),
            ),
          ),
          const BottomNavBar(),
        ],
      ),
    );
  }
}
