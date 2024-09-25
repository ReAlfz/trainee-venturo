import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/chekout/repositories/create_order_repository.dart';
import 'package:trainee/modules/features/chekout/views/components/fingerprint_dialog.dart';
import 'package:trainee/modules/features/chekout/views/components/order_success_dialog.dart';
import 'package:trainee/modules/features/chekout/views/components/pin_dialog.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/menu_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  RxList<MenuModel> cart = RxList<MenuModel>([]);
  late CreateOrderRepository repository;
  RxString cartViewState = 'success'.obs;

  void increaseQty(MenuModel item) {
    if (!cart.contains(item)) {
      item.jumlah++;
      cart.add(item);
      cart.refresh();
    } else {
      item.jumlah++;
      cart.refresh();
    }
  }

  void decreaseQty(MenuModel item) {
    if (cart.contains(item)) {
      if (item.jumlah > 1) {
        item.jumlah--;
        cart.add(item);
        cart.refresh();
      } else if (item.jumlah == 1) {
        item.jumlah = 0;
        cart.removeWhere((element) => element.idMenu == item.idMenu);
        cart.refresh();
      }
    }

    if (item.jumlah > 1) {
      item.jumlah--;
      cart.refresh();
    } else if (item.jumlah == 1) {
      item.jumlah = 0;
      cart.refresh();
    }
  }

  List<MenuModel> get foodItems => cart.where((element) => element.kategori == 'makanan').toList();
  List<MenuModel> get drinkItems => cart.where((element) => element.kategori == 'minuman').toList();

  int get totalPrice => cart.fold(
      0, (previousValue, element) => previousValue + (element.harga * element.jumlah)
  );

  int get discountPrice => totalPrice ~/ 100;
  int get grandTotal => totalPrice - discountPrice;

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
          showOrderSuccessDialog();
        }

      } else if (authType == 'pin') {
        await showPinDialog();
      }
    } else {
      await showPinDialog();
    }
  }

  Future<void> showPinDialog() async {
    Get.until(ModalRoute.withName(MainRoute.home));
    final String userPin = GlobalController.to.user.value!.pin;

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: PinDialog(pin: '${userPin}1'),
    );

    if (authenticated == true) {
      repository = CreateOrderRepository();
      await repository.createOrder(
        menu: cart,
        discount: discountPrice,
        grandTotalPrice: grandTotal,
      );
      showOrderSuccessDialog();

    } else if (authenticated != null) {
      Get.until(ModalRoute.withName(MainRoute.home));
    }
  }


// function dialog for checkout state //
  Future<String?> showFingerprintDialog() async {
    Get.until(ModalRoute.withName(MainRoute.home));
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(MainRoute.home));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );

    Get.back();
  }
}