import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/modules/order_model.dart';
import 'package:trainee/modules/features/order/repositories/order_repository.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find<OrderController>();

  late final OrderRepository repository;
  RxList<OrderModel> allOnGoingOrder = RxList<OrderModel>();
  RxList<OrderModel> allHistoryOrder = RxList<OrderModel>();

  RxString onGoingOrderState = 'loading'.obs;
  RxString orderHistoryState = 'loading'.obs;
  Rx<String> selectCategory = 'semua'.obs;
  Rx<DateTimeRange> selectDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Map<String, String> get dateFilterStatus => {
        'semua': 'Semua Status'.tr,
        'selesai': 'Selesai'.tr,
        'dibatalkan': 'Dibatalkan'.tr
      };

  @override
  void onInit() async {
    repository = OrderRepository();
    await repository.fetchDataFromApi(GlobalController.to.user.value!.idUser);

    await getOngoingOrders();
    await getOrderHistories();

    listOrder(allOnGoingOrder.take(pageSize).toList());
    listHistory(allHistoryOrder.take(pageSize).toList());
    super.onInit();
  }

  // start initialize list function //

  Future<void> getOngoingOrders() async {
    onGoingOrderState('loading');
    try {
      final result = repository.getOngoingOrder();
      final data = result.where((element) => element.status != 4).toList();
      allOnGoingOrder(data.reversed.toList());
      onGoingOrderState('success');
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      onGoingOrderState('error');
    }
  }

  Future<void> getOrderHistories() async {
    orderHistoryState('loading');

    try {
      final result = repository.getOrderHistory();
      allHistoryOrder(result.reversed.toList());
      orderHistoryState('success');
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      orderHistoryState('error');
    }
  }

  // end initialize list function //

  // start function smart refresh //
  RxInt currentPage = 1.obs;
  final int pageSize = 5;
  RxBool canLoadMore = true.obs;

  // start OnGoing tabview //
  RxList<OrderModel> listOrder = <OrderModel>[].obs;
  final RefreshController refreshControllerOnGoingOrder = RefreshController(initialRefresh: false);
  void onRefreshOnGoingOrder() async {
    try {
      canLoadMore(true);
      currentPage.value = 1;
      listOrder.addAll(allOnGoingOrder.take(pageSize).toList());
      refreshControllerOnGoingOrder.refreshCompleted();

    } catch (e, stacktrace) {
      refreshControllerOnGoingOrder.refreshFailed();
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  void onLoadingOnGoingOrder() async {
    try {
      currentPage.value++;
      final int startIndex = (currentPage.value - 1) * pageSize;
      final int endIndex = startIndex + pageSize;

      if (startIndex < allOnGoingOrder.length) {
        listOrder.addAll(allOnGoingOrder.getRange(
          startIndex,
          endIndex > allOnGoingOrder.length ? allOnGoingOrder.length : endIndex,
        ));
        refreshControllerOnGoingOrder.loadComplete();
      } else {
        canLoadMore(false);
        refreshControllerOnGoingOrder.loadNoData();
      }

    } catch (e, stacktrace) {
      refreshControllerOnGoingOrder.loadFailed();
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }
  // end OnGoing tabview //

  // start History tabview //
  RxList<OrderModel> listHistory = <OrderModel>[].obs;
  final RefreshController refreshControllerHistoryOrder = RefreshController(initialRefresh: false);
  void onRefreshHistoryOrder() async {
    try {
      canLoadMore(true);
      currentPage.value = 1;
      listHistory.addAll(allHistoryOrder.take(pageSize).toList());
      refreshControllerHistoryOrder.refreshCompleted();

    } catch (e, stacktrace) {
      refreshControllerHistoryOrder.refreshFailed();
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  void onLoadingHistoryOrder() async {
    try {
      currentPage.value++;
      final int startIndex = (currentPage.value - 1) * pageSize;
      final int endIndex = startIndex + pageSize;

      if (startIndex < allHistoryOrder.length) {
        listHistory.addAll(allHistoryOrder.getRange(
          startIndex,
          endIndex > allHistoryOrder.length ? allHistoryOrder.length : endIndex,
        ));
        refreshControllerHistoryOrder.loadComplete();
      } else {
        canLoadMore(false);
        refreshControllerHistoryOrder.loadNoData();
      }

    } catch (e, stacktrace) {
      refreshControllerHistoryOrder.loadFailed();
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }
  // end History tabview //
  // end function smart refresh //

  // start function for date //
  void setDateFilter({String? category, DateTimeRange? range}) {
    selectCategory(category);
    selectDateRange(range);
  }

  List<OrderModel> get filterHistoryOrder {
    final historyOrderList = listHistory.toList();

    if (selectCategory.value == 'dibatalkan') {
      historyOrderList.removeWhere((element) => element.status != 4);
    } else if (selectCategory.value == 'selesai') {
      historyOrderList.removeWhere((element) => element.status != 3);
    }

    historyOrderList.removeWhere((element) =>
        DateTime.parse(element.tanggal)
            .isBefore(selectDateRange.value.start) ||
        DateTime.parse(element.tanggal)
            .isAfter(selectDateRange.value.end)
    );

    historyOrderList.sort((a, b) => DateTime.parse(b.tanggal)
        .compareTo(DateTime.parse(a.tanggal))
    );

    return historyOrderList;
  }

  String get totalHistoryOrder {
    final total = filterHistoryOrder
        .where((element) => element.status == 3)
        .fold(
            0, (previousValue, element) => previousValue + element.totalBayar);

    return total.toString();
  }
  // end function for date //
}
