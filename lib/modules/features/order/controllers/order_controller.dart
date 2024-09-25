import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/modules/order_model.dart';
import 'package:trainee/modules/features/order/repositories/order_repository.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find<OrderController>();

  late final OrderRepository repository;
  RxList<OrderModel> onGoingOrder = RxList<OrderModel>();
  RxList<OrderModel> historyOrder = RxList<OrderModel>();

  RxString onGoingOrderState = 'loading'.obs;
  RxString onOrderHistoryState = 'loading'.obs;
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
  void onInit() {
    repository = OrderRepository();
    repository.fetchDataFromApi(GlobalController.to.user.value!.idUser);

    getOngoingOrder();
    getOrderHistory();
    super.onInit();
  }

  Future<void> getOngoingOrder() async {
    onGoingOrderState('loading');

    try {
      final result = repository.getOngoingOrder();
      final data = result.where((element) => element.status != 4).toList();
      onGoingOrder(data.reversed.toList());

      onGoingOrderState('success');
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );

      onGoingOrderState('error');
    }

    print('Ongoing state = $onGoingOrderState');
    print('length : ${onGoingOrder.length}');
  }

  Future<void> getOrderHistory() async {
    onOrderHistoryState('loading');

    try {
      final result = repository.getOrderHistory();
      historyOrder(result.reversed.toList());

      onOrderHistoryState('success');
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );

      onOrderHistoryState('error');
    }
  }

  void setDateFilter({String? category, DateTimeRange? range}) {
    selectCategory(category);
    selectDateRange(range);
  }

  List<OrderModel> get filterHistoryOrder {
    final historyOrderList = historyOrder.toList();

    if (selectCategory.value == 'dibatalkan') {
      historyOrderList.removeWhere((element) => element.status != 4);
    } else if (selectCategory.value == 'selesai') {
      historyOrderList.removeWhere((element) => element.status != 3);
    }

    historyOrderList.removeWhere((element) =>
        DateTime.parse(element.tanggal as String)
            .isBefore(selectDateRange.value.start) ||
        DateTime.parse(element.tanggal as String)
            .isBefore(selectDateRange.value.end)
    );

    historyOrderList.sort((a, b) => DateTime.parse(b.tanggal as String)
        .compareTo(DateTime.parse(a.tanggal as String))
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
}
