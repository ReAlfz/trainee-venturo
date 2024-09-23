import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/catalog/repositories/catalog_repository.dart';
import 'package:trainee/modules/features/home/modules/menu_item_model.dart';
import 'package:trainee/modules/features/home/modules/promo_item_model.dart';
import 'package:trainee/modules/features/home/repositories/list_repository.dart';
import 'package:trainee/modules/features/home/repositories/promo_repository.dart';
import 'package:trainee/shared/global_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final RxInt pageLoadMore = 0.obs;
  final RxInt pageView = 0.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  late final ListRepository listRepository;
  final RxList<MenuItemsModel> listItems = <MenuItemsModel>[].obs;
  final RxList<MenuItemsModel> selectedListItems = <MenuItemsModel>[].obs;

  late final PromoRepository promoRepository;
  RxList<PromoModel> listPromo = <PromoModel>[].obs;

  final RxBool canLoadMore = true.obs;
  final RxString selectCategory = 'semua'.obs;
  final RxString keyword = ''.obs;


  // kategori chip //
  final List<String> categories = [
    'semua',
    'makanan',
    'minuman',
  ];

  // initState //
  @override
  void onInit() async {
    super.onInit();
    listRepository = ListRepository();
    await listRepository.fetchListFromApi();
    await getListOfData();

    promoRepository = PromoRepository();
    listPromo.value = await promoRepository.fetchPromoFromApi();
  }

  // function for smart refresh //
  void onRefresh() async {
    await GlobalController.to.checkConnection(MainRoute.home);
    if (GlobalController.to.isConnect.value == true) {
      pageLoadMore(0);
      canLoadMore(true);

      final result = await getListOfData();
      if (result) {
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshFailed();
      }
    }
  }

  Future<bool> getListOfData() async {
    try {
      await GlobalController.to.checkConnection(MainRoute.home);
      if (GlobalController.to.isConnect.value == true) {
        final result = listRepository.getListOfData(offset: pageLoadMore.value * 10);
        // if (result.previous == null) {
        //   items.clear();
        // }
        if (result.next == null) {
          canLoadMore(false);
          refreshController.loadNoData();
        }

        listItems.addAll(result.data);
        refreshController.loadComplete();
        return true;
      } else {
        return false;
      }


    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshController.loadFailed();
      return false;
    }
  }

  Future<void> deleteItem(MenuItemsModel item) async {
    try {
      listRepository.deleteItem(item.idMenu);
      listItems.remove(item);

    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  // get listItems //
  List<MenuItemsModel> get filteredList => listItems.where(
          (element) => element.nama
          .toString()
          .toLowerCase()
          .contains(keyword.value.toLowerCase()) &&
          (selectCategory.value == 'semua' || element.kategori == selectCategory.value)
  ).toList();

  // get promoList //
  List<PromoModel> get promoList => listPromo;

  // push to detail //
  void pushPage(int id) async {
    await GlobalController.to.checkConnection(MainRoute.home);
    final CatalogRepository repository = CatalogRepository();
    final catalogData = await repository.fetchMenuFromApi(id);
    if (GlobalController.to.isConnect.value == true) {
      Get.toNamed(MainRoute.catalog, arguments: catalogData);
    }
  }

  void onNavTap(int index) => pageView.value = index;
}