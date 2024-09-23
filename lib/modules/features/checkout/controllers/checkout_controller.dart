import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/checkout/modules/cart_menu_model.dart';
import 'package:trainee/modules/features/checkout/modules/cart_model.dart';
import 'package:trainee/modules/features/checkout/repositories/cart_repository.dart';
import 'package:trainee/modules/features/checkout/views/components/fingerprint_dialog.dart';
import 'package:trainee/modules/features/checkout/views/components/order_success_dialog.dart';
import 'package:trainee/modules/features/checkout/views/components/pin_dialog.dart';
import 'package:trainee/shared/global_controller.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find<CheckoutController>();

  RxList<MenuCartModel> cart = <MenuCartModel>[].obs;
  RxString cartViewState = 'success'.obs;
  Rxn<CartModel> cartModel = Rxn<CartModel>();
  late final CartRepository repository;

  @override
  void onInit() {
    repository = CartRepository();
    super.onInit();
  }

  // function for cart //
  Future<void> fetchData() async {
    try {
      cartViewState('loading...');
      cartModel.value = await repository.fetchDataFromApi(GlobalController.to.user.value!.idUser);
      final result = cartModel.value!.menu;
      cart.assignAll(result);
      cartViewState('success');
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );

      cartViewState('error');
    }
  }

  void addToCart(MenuCartModel item) {
    if (cart.contains(item)) {
      removeFromCart(item);
    }
    cart.add(item);
  }

  void removeFromCart(MenuCartModel item) {
    cart.remove(item);
  }

  void increaseQty(MenuCartModel item) {
    item.jumlah++;
    cart.refresh();
  }

  void decreaseQty(MenuCartModel item) async {
    if (item.jumlah > 1) {
      item.jumlah--;
      cart.refresh();
    }
  }

  // specific list for cart //
  List<MenuCartModel> get foodItem =>
      cart.where(
              (element) => element.kategori == 'makanan'
      ).toList();

  List<MenuCartModel> get drinkItem =>
      cart.where(
              (element) => element.kategori == 'minuman'
      ).toList();


  // function for calculate //
  int get totalPrice =>
      cart.fold(
        0,
            (previousValue, element) =>
        previousValue +
            ((element.harga as int) * element.jumlah),
      );

  int get discountPrice => totalPrice ~/ 100;
  int get grandTotalPrice => totalPrice - discountPrice;

  // function for checkout food //
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
    Get.until(ModalRoute.withName(MainRoute.checkout));
    final String userPin = GlobalController.to.user.value!.pin;

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      showOrderSuccessDialog();

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

  Future<void> showOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(MainRoute.checkout));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
    );

    Get.back();
  }
}