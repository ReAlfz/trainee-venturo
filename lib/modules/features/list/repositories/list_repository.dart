import 'dart:convert';
import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/list/modules/menu_item_model.dart';
import 'package:trainee/modules/features/list/modules/paginated_data_model.dart';
import 'package:trainee/shared/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

class ListRepository {
  late List<MenuItems> listData = [];

  Future<void> fetchDataFromApi() async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    const url = 'menu/all';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        int statusCode = responseData['status_code'];
        if (statusCode == 200) {
          listData = List<MenuItems>.from(
              responseData['data'].map((x) => MenuItems.fromJson(x))
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
  }

  PaginatedData getListOfData({int offset = 0}) {
    int limit = 5;
    if (limit > listData.length) limit = listData.length;

    return PaginatedData(
      data: listData.getRange(offset, limit).toList(),
      next: limit < listData.length ? true : null,
      previous: offset > 0 ? true : null,
    );
  }

  void deleteItem(int id) => listData.removeWhere((element) => element.idMenu == id);
}