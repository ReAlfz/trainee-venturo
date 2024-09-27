import 'package:get/get.dart';
import 'package:trainee/modules/features/home/modules/catalog_model.dart';
import 'package:trainee/modules/features/home/modules/sub_catalog_model.dart';
import 'package:trainee/modules/features/home/repositories/catalog_repository.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class CatalogController extends GetxController {
  static CatalogController get to => Get.find();

  late final CatalogRepository catalogRepository;
  CatalogModel? catalogData;
  RxString catalogState = 'loading'.obs;

  Rx<MenuModel?> menuItem = Rx<MenuModel?>(null);
  RxList<SubCatalogModel> level = RxList<SubCatalogModel>();
  RxList<SubCatalogModel> topping = RxList<SubCatalogModel>();

  @override
  void onInit() async {
    super.onInit();
    catalogRepository = CatalogRepository();
    final menuId = int.parse(Get.parameters['menuId']!);
    catalogData = await catalogRepository.fetchMenuFromApi(menuId);
    catalogState('success');
  }
}