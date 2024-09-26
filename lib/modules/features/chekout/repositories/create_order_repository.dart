import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/chekout/modules/create_menu_model.dart';
import 'package:trainee/modules/features/chekout/modules/create_order_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/utils/services/dio_service.dart';

class CreateOrderRepository {
  Future<void> createOrder({
    required List<MenuModel> menu,
    required int discount,
    required int grandTotalPrice
  }) async {
    final dio = DioServices.dioCall(token: GlobalController.to.session.value);
    const url = 'order/add';

    CreateOrderModel orderModel = CreateOrderModel(
      idUser: GlobalController.to.user.value!.idUser,
      idVoucher: 1,
      potongan: discount,
      totalBayar: grandTotalPrice,
    );

    List<CreateMenuModel> listOrder = menu.map((element) => convertToOrder(element)).toList();
    final data = {
      'order': orderModel.toJson(),
      'menu': listOrder.map((menu) => menu.toJson()).toList()
    };

    try {
      await dio.post(url, data: data);
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );
    }
  }

  CreateMenuModel convertToOrder(MenuModel menu) {
    return CreateMenuModel(
      idMenu: menu.idMenu,
      harga: menu.harga,
      level: "",
      topping: menu.topping.map((e) => e as int).toList(),
      jumlah: menu.jumlah,
    );
  }
}