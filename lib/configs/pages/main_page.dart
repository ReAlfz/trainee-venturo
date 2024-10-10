import 'package:get/get.dart';
import 'package:trainee/modules/features/chekout/binddings/voucher_binding.dart';
import 'package:trainee/modules/features/chekout/views/ui/voucher_view.dart';
import 'package:trainee/modules/features/location/bindings/location_binding.dart';
import 'package:trainee/modules/features/location/views/ui/location_view.dart';

import '../../modules/features/chekout/binddings/checkout_binding.dart';
import '../../modules/features/chekout/views/ui/checkout_view.dart';
import '../../modules/features/error_handler/views/ui/NoConnectionView.dart';
import '../../modules/features/forgot_password/binddings/forgot_password_bindding.dart';
import '../../modules/features/forgot_password/binddings/otp_bindding.dart';
import '../../modules/features/forgot_password/views/ui/forgot_password_view.dart';
import '../../modules/features/forgot_password/views/ui/otp_view.dart';
import '../../modules/features/home/bindings/home_binding.dart';
import '../../modules/features/home/views/ui/home_view.dart';
import '../../modules/features/sign_in/binddings/sign_in_bindding.dart';
import '../../modules/features/sign_in/views/ui/sign_in_view.dart';
import '../../modules/features/splash/bindings/splash_binding.dart';
import '../../modules/features/splash/views/ui/splash_view.dart';
import '../routes/main_route.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: MainRoute.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),

    GetPage(
      name: MainRoute.noConnection,
      page: () => const NoConnectionView(),
    ),

    GetPage(
      name: MainRoute.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),

    GetPage(
      name: MainRoute.opt,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),

    GetPage(
      name: MainRoute.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: MainRoute.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),

    GetPage(
      name: MainRoute.location,
      page: () => const LocationView(),
      binding: LocationBinding(),
    ),

    GetPage(
      name: MainRoute.voucher,
      page: () => const VoucherView(),
      binding: VoucherBinding(),
    ),
  ];
}
