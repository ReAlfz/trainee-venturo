import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

import '../models/promo_item_model.dart';

class ListRepository {
  Future<List<MenuModel>> fetchListFromApi() async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    const url = 'menu/all';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['status_code'] == 200) {
          return List<MenuModel>.from(
              responseData['data'].map((x) => MenuModel.fromJson(x))
          ).toList();
        }

      } else {
        log('failed with status: ${response.statusCode}');
        log('Response body: ${response.data}');
      }

    } catch (ex, stacktrace) {
      await Sentry.captureException(
        ex,
        stackTrace: stacktrace,
      );
    }

    return [];
  }

  Future<List<PromoModel>> fetchPromoFromApi() async {
    List<PromoModel> list = [];
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    const url = 'promo/all';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        if (responseData['status_code'] == 200) {
          list = List<PromoModel>.from(
              responseData['data'].map((x) => PromoModel.fromJson(x))
          );
        }

      } else {
        log('failed with status: ${response.statusCode}');
        log('Response body: ${response.data}');
      }

    } catch (ex, stacktrace) {
      await Sentry.captureException(
        ex,
        stackTrace: stacktrace,
      );
    }

    return list;
  }
}