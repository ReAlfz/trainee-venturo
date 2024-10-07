import 'package:trainee/modules/features/food/promo/models/detail_promo_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';


class PromoRepository {
  Future<DetailPromoModel?> fetchPromoFromApi(int idPromo) async {
    final DetailPromoModel model;
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    const url = 'user';
    return null;
  }
}