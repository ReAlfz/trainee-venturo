import 'dart:async';

import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/modules/order_model.dart';
import 'package:trainee/modules/features/order/repositories/order_repository.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find();

  late final OrderRepository repository;

  RxString orderDetailState = 'loading'.obs;
  Rxn<OrderModel> order = Rxn();

  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    repository = OrderRepository();
    final orderId = int.parse(Get.parameters as String);

  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> getOrderDetail(int orderId, {bool isPeriodic = false}) async {
    if (!isPeriodic) {
      orderDetailState('loading');
    }

    try {
      final result = repository.getOrderDetail(orderId);
      orderDetailState('success');
      order(result);
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );

      orderDetailState('error');
    }
  }

  List<MenuModel> get foodItem {
    return order.value?.menu.where(
            (element) => element.kategori == 'makanan'
    ).toList() ?? [];
  }

  List<MenuModel> get drinkItem {
    return order.value?.menu.where(
            (element) => element.kategori == 'minuman'
    ).toList() ?? [];
  }
}