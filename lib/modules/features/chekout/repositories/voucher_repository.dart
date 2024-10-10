import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/chekout/modules/voucher_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

class VoucherRepository {
  Future<List<VoucherModel>> fetchVoucherFromApi() async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    const url = 'voucher/all';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status_code'] == 200) {
          return List<VoucherModel>.from(
            responseData['data'].map((x) => VoucherModel.fromJson(x)),
          ).toList();
        }
      }
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );
    }
    return [];
  }
}
