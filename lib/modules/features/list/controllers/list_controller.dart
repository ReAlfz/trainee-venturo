import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/list/modules/menu_item_model.dart';
import 'package:trainee/modules/features/list/repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();

  late final ListRepository repository;
  final RxInt page = 0.obs;
  final RxList<MenuItems> items = <MenuItems>[].obs;
  final RxList<MenuItems> selectedItems = <MenuItems>[].obs;
  final RxBool canLoadMore = true.obs;
  final RxString selectCategory = 'semua'.obs;
  final RxString keyword = ''.obs;

  final List<String> categories = [
    'semua',
    'makanan',
    'minuman',
  ];

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    repository = ListRepository();
    await repository.fetchDataFromApi();
    await getListOfData();
  }

  void onRefresh() async {
    page(0);
    canLoadMore(true);

    final result = await getListOfData();
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  List<MenuItems> get filteredList => items.where(
        (element) => element.nama
            .toString()
            .toLowerCase()
            .contains(keyword.value.toLowerCase()) &&
            (selectCategory.value == 'semua' || element.kategori == selectCategory.value)
  ).toList();

  Future<bool> getListOfData() async {
    try {
      final result = repository.getListOfData(offset: page.value * 10);
      // if (result.previous == null) {
      //   items.clear();
      // }
      if (result.next == null) {
        canLoadMore(false);
        refreshController.loadNoData();
      }

      items.addAll(result.data);
      refreshController.loadComplete();
      return true;

    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshController.loadFailed();
      return false;
    }
  }

  Future<void> deleteItem(MenuItems item) async {
    try {
      repository.deleteItem(item.idMenu);
      items.remove(item);

    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}