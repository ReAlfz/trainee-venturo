import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/checkout/repositories/cart_repository.dart';

// class CheckoutController extends GetxController {
//   static CheckoutController get to => Get.find<CheckoutController>();
//
//   RxList<Map<String, dynamic>> cart = <Map<String, dynamic>>[].obs;
//   RxString cartViewState = 'success'.obs;
//   late final CartRepository repository;
//
//   @override
//   void onInit() {
//     repository = CartRepository();
//     super.onInit();
//   }
//
//   // function for cart //
//   Future<void> fetchData() async {
//     try {
//       cartViewState('loading...');
//       final result = repository.getListData();
//       cart.assignAll(result);
//       cartViewState('success');
//     } catch (e, stacktrace) {
//       await Sentry.captureException(
//         e,
//         stackTrace: stacktrace,
//       );
//
//       cartViewState('error');
//     }
//   }
//
//   void addToCart(Map<String, dynamic> item) {
//     if (cart.contains(item)) {
//       removeFromCart(item);
//     }
//     cart.add(item);
//   }
//
//   void removeFromCart(Map<String, dynamic> item) {
//     cart.remove(item);
//   }
//
//   void increaseQty(Map<String, dynamic> item) {
//     item['qty']++;
//     cart.refresh();
//   }
//
//   void decreaseQty(Map<String, dynamic> item) async {
//     if (item['qty'] > 1) {
//       item['qty']--;
//       cart.refresh();
//     }
//   }
//
//   // specific list for cart //
//   List<Map<String, dynamic>> get foodItem =>
//       cart.where(
//               (element) => element['item']['category'] == 'food'
//       ).toList();
//
//   List<Map<String, dynamic>> get drinkItem =>
//       cart.where(
//               (element) => element['item']['category'] == 'food'
//       ).toList();
//
//
//   // function for calculate //
//   int get totalPrice =>
//       cart.fold(
//         0,
//             (previousValue, element) =>
//         previousValue +
//             ((element['item']['harga'] as int) * element['qty'] as int);,
//       );
//
//   int get discountPrice => totalPrice ~/ 100;
//   int get grandTotalPrice => totalPrice - discountPrice;
//
//   // function for checkout food //
//   Future<void> verify() async {
//     final LocalAuthentication localAuth = LocalAuthentication();
//     final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
//     final bool isBiometricSupport = await localAuth.isDeviceSupported();
//
//     if (canCheckBiometrics && isBiometricSupport) {
//       final String? authType = await showFingerprintDialog();
//
//       if (authType == 'fingerprint') {
//         final bool authenticated = await localAuth.authenticate(
//           localizedReason: 'Please authenticate to confirm order'.tr,
//           options: const AuthenticationOptions(
//             biometricOnly: true,
//           ),
//         );
//
//         if (authenticated) {
//           showOrderSuccessDialog();
//         }
//
//       } else if (authType == 'pin') {
//         await showPinDialog();
//       }
//     } else {
//       await showPinDialog();
//     }
//   }
//
//   Future<void> showPinDialog() async {
//     Get.until(ModalRoute.withName(MainRoute.checkout));
//     const userPin = '123456';
//
//     final bool? authenticated = await Get.defaultDialog(
//       title: '',
//       titleStyle: const TextStyle(fontSize: 0),
//       content: const PinDialog(pin: userPin),
//     );
//
//     if (authenticated == true) {
//       showOrderSuccessDialog();
//
//     } else if (authenticated != null) {
//       Get.until(ModalRoute.withName(MainRoute.checkout));
//     }
//   }
//
//
//   // function dialog for checkout state //
//   Future<String?> showFingerprintDialog() async {
//     Get.until(ModalRoute.withName(MainRoute.checkout));
//     final result = await Get.defaultDialog(
//       title: '',
//       titleStyle: const TextStyle(fontSize: 0),
//       content: const FingerprintDialog(),
//     );
//
//     return result;
//   }
//
//   Future<void> showOrderSuccessDialog() async {
//     Get.until(ModalRoute.withName(MainRoute.checkout));
//     await Get.defaultDialog(
//       title: '',
//       titleStyle: const TextStyle(fontSize: 0),
//       content: const OrderSuccessDialog(),
//     );
//
//     Get.back();
//   }
// }