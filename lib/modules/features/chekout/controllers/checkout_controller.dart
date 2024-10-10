import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/chekout/repositories/create_order_repository.dart';
import 'package:trainee/modules/features/chekout/views/components/fingerprint_dialog.dart';
import 'package:trainee/modules/features/chekout/views/components/order_success_dialog.dart';
import 'package:trainee/modules/features/chekout/views/components/pin_dialog.dart';
import 'package:trainee/modules/features/food/list_food/controller/list_food_controller.dart';
import 'package:trainee/modules/features/home/controllers/home_controller.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/menu_model.dart';
import 'package:trainee/utils/services/firebase_message_service.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  RxList<MenuModel> cart = <MenuModel>[].obs;
  late CreateOrderRepository createOrderRepository;
  RxString cartViewState = 'success'.obs;

  void increaseQty(MenuModel item) {
    if (!cart.contains(item)) {
      item.jumlah++;
      cart.add(item);
    } else {
      item.jumlah++;
    }
    cart.refresh();
    ListFoodController.to.listMenu.refresh();
  }

  void decreaseQty(MenuModel item) {
    if (item.jumlah > 1) {
      item.jumlah--;
    } else {
      item.jumlah--;
      cart.remove(item);
    }
    cart.refresh();
    ListFoodController.to.listMenu.refresh();
  }

  List<MenuModel> get foodItems =>
      cart.where((element) => element.kategori == 'makanan').toList();

  List<MenuModel> get drinkItems =>
      cart.where((element) => element.kategori == 'minuman').toList();

  List<MenuModel> get snackItems =>
      cart.where((element) => element.kategori == 'snack').toList();

  int get totalPrice => cart.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.harga * element.jumlah));

  int get discountPrice => totalPrice ~/ 100;

  int get grandTotal => totalPrice - discountPrice;

  RxString voucher = 'Pilih Voucher'.tr.obs;

  // function for handle transaction //
  Future<void> verify() async {
    final LocalAuthentication localAuth = LocalAuthentication();
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    final bool isBiometricSupport = await localAuth.isDeviceSupported();

    if (canCheckBiometrics && isBiometricSupport) {
      final String? authType = await showFingerprintDialog();

      if (authType == 'fingerprint') {
        final bool authenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to confirm order'.tr,
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );

        if (authenticated) {
          int orderId = await configList();
          showOrderSuccessDialog(orderId: orderId);
        }
      } else if (authType == 'pin') {
        await showPinDialog();
      }
    } else {
      await showPinDialog();
    }
  }

  Future<void> showPinDialog() async {
    Get.until(ModalRoute.withName(MainRoute.checkout));
    final String userPin = GlobalController.to.user.value!.pin;

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      radius: 30,
      content: PinDialog(pin: '${userPin}1'),
    );

    if (authenticated == true) {
      int orderId = await configList();
      showOrderSuccessDialog(orderId: orderId);
    } else if (authenticated != null) {
      Get.until(ModalRoute.withName(MainRoute.checkout));
    }
  }

// function dialog for checkout state //
  Future<String?> showFingerprintDialog() async {
    Get.until(ModalRoute.withName(MainRoute.checkout));
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showOrderSuccessDialog({required int orderId}) async {
    RemoteMessage message = RemoteMessage(
        notification: const RemoteNotification(
          title: 'New Order',
          body: "There's new order, click this for detail",
        ),
        data: {'id_order': '$orderId'});
    await FirebaseMessageService.handleNotif(message);

    Get.until(ModalRoute.withName(MainRoute.checkout));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      radius: 30,
      content: const OrderSuccessDialog(),
    );
    Get.until((route) => route.settings.name == MainRoute.home);
    HomeController.to.foodKey!.currentState!.popUntil(
      (route) => route.settings.name == MainRoute.food,
    );
    HomeController.to.changePage(1);
  }

  Future<int> configList() async {
    createOrderRepository = CreateOrderRepository();
    int orderId = await createOrderRepository.createOrder(
      menu: cart,
      discount: discountPrice,
      grandTotalPrice: grandTotal,
    );
    cart.clear();
    for (var element in ListFoodController.to.listMenu) {
      element.jumlah = 0;
    }
    ListFoodController.to.listMenu.refresh();
    return orderId;
  }

  void pushVoucher() {
    Get.toNamed(MainRoute.voucher);
  }
}
