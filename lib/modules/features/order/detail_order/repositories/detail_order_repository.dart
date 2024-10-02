import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/utils/services/dio_service.dart';

import '../../list_order/modules/order_model.dart';

class DetailOrderRepository {
  Future<OrderModel?> getDetailOrder(int idOrder) async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'order/detail/$idOrder';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['status_code'] == 200) {
          List<MenuModel> listMenu = List<MenuModel>.from(
              responseData['data']['detail'].map((x) => MenuModel.fromJson(x))
          );
          OrderModel order = OrderModel.customJson(responseData['data']['order'], listMenu);
          return order;
        }
      } else {
        log('failed with status: ${response.statusCode}');
        log('Response body: ${response.data}');
      }

    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );
    }

    return null;
  }
}