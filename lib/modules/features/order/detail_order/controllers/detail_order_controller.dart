import 'dart:async';

import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

import '../../list_order/modules/order_model.dart';
import '../repositories/detail_order_repository.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find();

  late final DetailOrderRepository repository;

  RxString orderDetailState = 'loading'.obs;
  Rxn<OrderModel> order = Rxn();

  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    repository = DetailOrderRepository();
    final orderId = int.parse(Get.parameters['orderId']!);
    getOrderDetail(orderId).then((value) {
      timer = Timer.periodic(
          const Duration(seconds: 10), (timer) {
        (_) => getOrderDetail(orderId, isPeriodic: true);
      });
    });
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
      final result = await repository.getDetailOrder(orderId);
      order(result);
      orderDetailState('success');

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