import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/catalog/repositories/catalog_repository.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/modules/features/home/modules/promo_item_model.dart';
import 'package:trainee/modules/features/home/repositories/list_repository.dart';
import 'package:trainee/modules/features/home/repositories/promo_repository.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class HomeListController extends GetxController {
  static HomeListController get to => Get.find();

  late final ListRepository listRepository;
  final RxList<MenuModel> allListMenu = <MenuModel>[].obs;

  late final PromoRepository promoRepository;
  RxList<PromoModel> listPromo = <PromoModel>[].obs;

  final RxBool canLoadMore = true.obs;
  final RxString selectCategory = 'semua'.obs;
  final RxString keyword = ''.obs;

  final List<String> categories = [
    'semua',
    'makanan',
    'minuman',
  ];

  @override
  void onInit() async {
    super.onInit();
    listRepository = ListRepository();
    allListMenu.value = await listRepository.fetchListFromApi();
    listMenu(allListMenu.take(pageSize).toList());

    promoRepository = PromoRepository();
    listPromo.value = await promoRepository.fetchPromoFromApi();
  }

  // start function for smart refresh //
  RxInt currentPage = 1.obs;
  final int pageSize = 5;
  RxList<MenuModel> listMenu = RxList<MenuModel>();
  final RefreshController refreshController = RefreshController(initialRefresh: false);

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

  List<MenuModel> get filteredList => listMenu.where(
          (element) => element.nama
          .toString()
          .toLowerCase()
          .contains(keyword.value.toLowerCase()) &&
          (selectCategory.value == 'semua' || element.kategori == selectCategory.value)
  ).toList();


  List<PromoModel> get promoList => listPromo;
  // end function for listMenu //

  // push to detail //
  void pushPage(int id) async {
    await GlobalController.to.checkConnection(MainRoute.home);
    final CatalogRepository repository = CatalogRepository();
    final catalogData = await repository.fetchMenuFromApi(id);
    if (GlobalController.to.isConnect.value == true) {
      Get.toNamed(MainRoute.catalog, arguments: catalogData);
    }
  }

  void increaseQty(MenuModel menuModel) {
    menuModel.jumlah++;
    allListMenu.refresh();
  }

  void decreaseQty(MenuModel menuModel) async {
    if (menuModel.jumlah > 1) {
      menuModel.jumlah--;
    } else if (menuModel.jumlah == 1) {
      menuModel.jumlah = 0;
    }
    allListMenu.refresh();
  }
}