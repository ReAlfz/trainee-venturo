import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/modules/order_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

class OrderRepository {
  late List<OrderModel> listData = [];
  Future<void> fetchDataFromApi(int id) async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'order/user/$id';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['status_code'] == 200) {
          listData = List<OrderModel>.from(
              responseData['data'].map((x) => OrderModel.fromJson(x))
          );
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
  }

  List<OrderModel> getOngoingOrder() => listData.where((element) => element.status < 3).toList();
  List<OrderModel> getOrderHistory() => listData.where((element) => element.status > 2).toList();
}