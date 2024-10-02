import 'package:get/get.dart';

import '../../modules/features/chekout/binddings/checkout_bindding.dart';
import '../../modules/features/chekout/views/ui/checkout_view.dart';
import '../../modules/features/error_handler/views/ui/NoConnectionView.dart';
import '../../modules/features/food/detail_food/bindings/detail_food_bindding.dart';
import '../../modules/features/food/detail_food/views/ui/detail_food_view.dart';
import '../../modules/features/forgot_password/binddings/forgot_password_bindding.dart';
import '../../modules/features/forgot_password/binddings/otp_bindding.dart';
import '../../modules/features/forgot_password/views/ui/forgot_password_view.dart';
import '../../modules/features/forgot_password/views/ui/otp_view.dart';
import '../../modules/features/home/bindings/home_binding.dart';
import '../../modules/features/home/views/ui/home_view.dart';
import '../../modules/features/order/detail_order/bindings/detail_order_binding.dart';
import '../../modules/features/order/detail_order/views/ui/detail_order_view.dart';
import '../../modules/features/order/list_order/bindings/order_binding.dart';
import '../../modules/features/order/list_order/views/ui/order_view.dart';
import '../../modules/features/profile/bindings/profile_binding.dart';
import '../../modules/features/profile/views/ui/profile_view.dart';
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
      children: [
        GetPage(
          name: MainRoute.order,
          page: () => const OrderView(),
          binding: OrderBinding(),
          children: [
            GetPage(
              name: MainRoute.orderDetail,
              page: () => const DetailOrderView(),
              binding: DetailOrderBinding(),
            ),
          ]
        ),

        GetPage(
          name: MainRoute.profile,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),

        GetPage(
          name: MainRoute.foodDetail,
          page: () => const FoodDetailView(),
          binding: DetailFoodBinding(),
        ),
      ]
    ),

    GetPage(
      name: MainRoute.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
