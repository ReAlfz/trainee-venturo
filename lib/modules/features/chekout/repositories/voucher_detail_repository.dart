import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/chekout/modules/voucher_detail_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';


class VoucherDetailRepository {
  Future<VoucherDetailModel?> fetchDataFromApi({required int idVoucher}) async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'voucher/detail/$idVoucher';
    
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status_code'] == 200) {
          return VoucherDetailModel.fromJson(responseData['data']);
        }
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