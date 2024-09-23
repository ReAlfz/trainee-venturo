import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/checkout/modules/cart_model.dart';
import 'package:trainee/shared/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

class CartRepository {
  Future<CartModel?> fetchDataFromApi(int id) async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'order/user/$id';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['status_code'] == 200) {
          CartModel? cartModel = CartModel.fromJson(responseData['data']);
          return cartModel;
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