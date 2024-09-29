import 'package:get/get.dart';
import 'package:trainee/modules/features/list_food/modules/detail_food_model.dart';
import 'package:trainee/modules/features/list_food/repositories/detail_food_repository.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class DetailFoodController extends GetxController {
  static DetailFoodController get to => Get.find();

  late final DetailFoodRepository catalogRepository;
  Rxn<MenuModel> menu = Rxn<MenuModel>();
  Rxn<DetailFoodModel> catalogData = Rxn<DetailFoodModel>();
  RxString catalogState = 'loading'.obs;
  RxString catatan = ''.obs;
  RxInt currentLevel = 1.obs;
  RxInt quantity = 0.obs;

  void onIncrease() => quantity++;
  void onDecrease() => quantity--;

  @override
  void onInit() async {
    super.onInit();
    catalogRepository = DetailFoodRepository();
    final idMenu = int.parse(Get.parameters['idMenu']!);
    menu(Get.arguments);
    catalogData(await catalogRepository.fetchMenuFromApi(idMenu));
    quantity.value = menu.value!.jumlah;
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
      topping: catalogData.value!.topping.map((element) => element.idMenu).toList(),
      level: currentLevel.value,
      jumlah: quantity.value,
      total: menu.value!.total,
      catatan: catatan.value,
    );

    Get.back(result: data);
  }
}