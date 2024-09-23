import 'package:trainee/constants/cores/assets/shared_preference_key.dart';
import 'package:trainee/modules/features/checkout/modules/cart_model.dart';
import 'package:trainee/shared/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';

class CartRepository {
  Future<CartModel> fetchDataFromApi(String id) {
    CartModel cartModel;
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    final url = 'order/user/$id';


  }
}