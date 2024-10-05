import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/food/detail_food/views/components/topping_bottom_sheet.dart';
import 'package:trainee/modules/features/food/detail_food/views/components/catatan_bottom_sheet.dart';
import 'package:trainee/modules/features/food/list_food/controller/list_food_controller.dart';
import 'package:trainee/modules/features/food/list_food/models/sub_catalog_model.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';

import '../../../../global_models/menu_model.dart';
import '../../../chekout/controllers/checkout_controller.dart';
import '../models/detail_food_model.dart';
import '../repositories/detail_food_repository.dart';
import '../views/components/level_bottom_sheet.dart';

class DetailFoodController extends GetxController {
  static DetailFoodController get to => Get.find();

  late final DetailFoodRepository catalogRepository;
  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<DetailFoodModel> catalogData = Rxn<DetailFoodModel>();
  late TextEditingController textController;

  RxString catatan = ''.obs;
  RxString currentLevel = ''.obs;
  RxList<SubCatalogModel> currentTopping = <SubCatalogModel>[].obs;
  RxList<int> topping = <int>[].obs;

  RxString catalogState = 'loading'.obs;
  RxInt quantity = 0.obs;

  void onIncrease() => quantity++;

  void onDecrease() => quantity--;

  @override
  void onInit() async {
    super.onInit();
    catalogRepository = DetailFoodRepository();
    menu(Get.arguments);
    catalogData(await catalogRepository.fetchMenuFromApi(menu.value!.idMenu));
    quantity.value = menu.value!.jumlah;
    currentLevel.value =
        (menu.value!.level != -1) ? '${menu.value!.level}' : '';

    List<SubCatalogModel> filteredList = catalogData.value!.topping
        .where((element) => menu.value!.topping.contains(element.idDetail))
        .toList();
    print(filteredList.length);

    currentTopping.value =
        (menu.value!.topping.isNotEmpty) ? filteredList : [];

    catatan.value =
        (menu.value!.catatan != '') ? menu.value!.catatan : 'tambahkan catatan';
    catalogState('success');
  }

  void updateData() {
    MenuModel data = MenuModel(
      idMenu: menu.value!.idMenu,
      nama: menu.value!.nama,
      kategori: menu.value!.kategori,
      harga: menu.value!.harga,
      foto: menu.value!.foto,
      status: menu.value!.status,
      deskripsi: menu.value!.deskripsi,
      topping: currentTopping.map((element) => element.idDetail).toList(),
      level: (currentLevel.value != '') ? int.parse(currentLevel.value) : 1,
      jumlah: quantity.value,
      total: menu.value!.total,
      catatan: catatan.value,
    );

    Get.back(result: data, id: HomeController.to.navigatorFoodId);
  }

  void selectOption(String code) async {
    switch (code) {
      case 'level':
        final result = await Get.bottomSheet(
          const LevelBottomSheet(),
        );

        if (result != null) currentLevel.value = result;
        break;

      case 'topping':
        Get.bottomSheet(const ToppingBottomSheet());
        break;

      default:
        textController = TextEditingController(text: catatan.value);
        final result = await Get.bottomSheet(
          const CatatanBottomSheet(),
        );

        if (result != null) catatan.value = result;
    }
  }

  void checkout() {
    onIncrease();
    MenuModel data = MenuModel(
      idMenu: menu.value!.idMenu,
      nama: menu.value!.nama,
      kategori: menu.value!.kategori,
      harga: menu.value!.harga,
      foto: menu.value!.foto,
      status: menu.value!.status,
      deskripsi: menu.value!.deskripsi,
      topping: currentTopping.map((element) => element.idDetail).toList(),
      level: (currentLevel.value != '') ? int.parse(currentLevel.value) : 1,
      jumlah: quantity.value,
      total: menu.value!.total,
      catatan: catatan.value,
    );

    int cartIndex = CheckoutController.to.cart.indexWhere((element) => element.idMenu == data.idMenu);
    if (cartIndex != -1) {
      (data.jumlah > 0)
          ? CheckoutController.to.cart[cartIndex] = data
          : CheckoutController.to.cart.removeAt(cartIndex);

    } else {
      if (data.jumlah > 0) {
        CheckoutController.to.cart.add(data);
      }
    }

    ListFoodController.to.listMenu.refresh();
    Get.toNamed(MainRoute.checkout);
  }
}
