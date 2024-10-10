import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/chekout/controllers/checkout_controller.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

import '../models/promo_item_model.dart';
import '../repositories/list_repository.dart';

class ListFoodController extends GetxController {
  static ListFoodController get to => Get.find();

  late final ListRepository listRepository;
  final RxList<MenuModel> allListMenu = <MenuModel>[].obs;
  final RxList<PromoModel> listPromo = <PromoModel>[].obs;

  RxString listFoodState = 'loading'.obs;

  final RxBool canLoadMore = true.obs;
  final RxString selectCategory = 'semua'.obs;
  final RxString keyword = ''.obs;

  final List<String> categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Snack',
  ];

  final List<IconData> categoryIcon = [
    Icons.list_alt_outlined,
    Icons.fastfood_outlined,
    Icons.coffee_outlined,
    Icons.no_food_outlined
  ];

  @override
  void onInit() async {
    super.onInit();
    listRepository = ListRepository();
    allListMenu.value = await listRepository.fetchListFromApi();
    listPromo.value = await listRepository.fetchPromoFromApi();
    listMenu(allListMenu.take(pageSize).toList());
    listFoodState('success');
  }

  // start function for smart refresh //
  RxInt currentPage = 1.obs;
  final int pageSize = 3;
  RxList<MenuModel> listMenu = RxList<MenuModel>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    try {
      canLoadMore(true);
      currentPage.value = 1;
      listMenu.addAll(allListMenu.take(pageSize).toList());
      refreshController.refreshCompleted();
    } catch (e, stacktrace) {
      refreshController.refreshFailed();
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  void onLoading() async {
    try {
      canLoadMore(true);
      currentPage.value++;
      final int startIndex = (currentPage.value - 1) * pageSize;
      final int endIndex = startIndex + pageSize;

      if (startIndex < allListMenu.length) {
        listMenu.addAll(allListMenu.getRange(
          startIndex,
          endIndex > allListMenu.length ? allListMenu.length : endIndex,
        ));
        refreshController.loadComplete();
      } else {
        canLoadMore(false);
        refreshController.loadNoData();
      }
    } catch (e, stacktrace) {
      refreshController.loadFailed();
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  // end function for smart refresh //

  // start function for listMenu //
  Future<void> deleteItem(MenuModel item) async {
    try {
      listMenu.removeWhere((element) => element.idMenu == item.idMenu);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  // all list //
  List<MenuModel> get filteredList => listMenu
      .where((element) =>
          element.nama
              .toString()
              .toLowerCase()
              .contains(keyword.value.toLowerCase()) &&
          (selectCategory.value == 'semua' ||
              element.kategori == selectCategory.value))
      .toList();

  List<PromoModel> get promoList => listPromo;

  // end function for listMenu //

  // start function for change list //
  Future<void> pushPage(MenuModel menu) async {
    try {
      final result = await HomeController.to.foodKey!.currentState!.pushNamed(
        MainRoute.foodDetail,
        arguments: menu,
      );

      if (result != null) {
        MenuModel data = result as MenuModel;
        int menuIndex =
            listMenu.indexWhere((element) => element.idMenu == data.idMenu);
        listMenu[menuIndex] = data;

        int cartIndex = CheckoutController.to.cart
            .indexWhere((element) => element.idMenu == data.idMenu);
        if (cartIndex != -1) {
          (data.jumlah > 0)
              ? CheckoutController.to.cart[cartIndex] = data
              : CheckoutController.to.cart.removeAt(cartIndex);
        } else {
          if (data.jumlah > 0) {
            CheckoutController.to.cart.add(data);
          }
        }
      }
    } catch (e, stacktrace) {
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  void pushPromo({required int index}) {
    final idPromo = promoList[index].idPromo;
    HomeController.to.foodKey!.currentState!.pushNamed(
      MainRoute.promo,
      arguments: idPromo,
    );
  }
}
