import 'package:get/get.dart';
import 'package:trainee/modules/features/catalog/modules/catalog_model.dart';
import 'package:trainee/modules/features/catalog/modules/sub_catalog_model.dart';
import 'package:trainee/modules/features/catalog/repositories/catalog_repository.dart';
import 'package:trainee/modules/features/list/modules/menu_item_model.dart';

class CatalogController extends GetxController {
  static CatalogController get to => Get.find();

  late final CatalogRepository catalogRepository = CatalogRepository();
  CatalogModel? catalogData;
  Rx<MenuItemsModel?> menuItem = Rx<MenuItemsModel?>(null);
  RxList<SubCatalogModel> level = RxList<SubCatalogModel>();
  RxList<SubCatalogModel> topping = RxList<SubCatalogModel>();

  @override
  void onInit() async {
    catalogData = Get.arguments as CatalogModel;
    menuItem = catalogData!.menu.obs;
    level.value = catalogData!.level;
    topping.value = catalogData!.topping;
    super.onInit();
  }

  void popPage() => Get.back();
}