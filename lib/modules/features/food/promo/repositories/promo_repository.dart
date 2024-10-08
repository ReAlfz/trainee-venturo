import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/food/promo/models/detail_promo_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';


class PromoRepository {
  Future<DetailPromoModel?> fetchPromoFromApi(int idPromo) async {
    final DetailPromoModel model;
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'promo/detail/$idPromo';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status_code'] == 200) {
          model = DetailPromoModel.fromJson(responseData['data']);
          return model;
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