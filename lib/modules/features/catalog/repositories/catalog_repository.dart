import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/catalog/modules/catalog_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

class CatalogRepository {

  Future<CatalogModel?> fetchMenuFromApi(int id) async {
    CatalogModel catalogModel;
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'menu/detail/$id';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status_code'] == 200) {
          catalogModel = CatalogModel.fromJson(responseData['data']);
          return catalogModel;
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