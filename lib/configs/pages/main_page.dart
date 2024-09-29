import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/chekout/binddings/checkout_bindding.dart';
import 'package:trainee/modules/features/chekout/views/ui/checkout_view.dart';
import 'package:trainee/modules/features/forgot_password/binddings/forgot_password_bindding.dart';
import 'package:trainee/modules/features/forgot_password/binddings/otp_bindding.dart';
import 'package:trainee/modules/features/forgot_password/views/ui/forgot_password_view.dart';
import 'package:trainee/modules/features/forgot_password/views/ui/otp_view.dart';
import 'package:trainee/modules/features/error_handler//views/ui/NoConnectionView.dart';
import 'package:trainee/modules/features/home/binddings/home_bindding.dart';
import 'package:trainee/modules/features/home/views/ui/home_view.dart';
import 'package:trainee/modules/features/list_food/binddings/detail_food_bindding.dart';
import 'package:trainee/modules/features/list_food/views/ui/detail_food_view.dart';
import 'package:trainee/modules/features/order/binddings/detail_order_bindding.dart';
import 'package:trainee/modules/features/order/binddings/order_bindding.dart';
import 'package:trainee/modules/features/order/views/ui/detail_order_view.dart';
import 'package:trainee/modules/features/order/views/ui/order_view.dart';
import 'package:trainee/modules/features/profile/binddings/profile_bindding.dart';
import 'package:trainee/modules/features/profile/views/ui/profile_view.dart';
import 'package:trainee/modules/features/sign_in/binddings/sign_in_bindding.dart';
import 'package:trainee/modules/features/sign_in/views/ui/sign_in_view.dart';
import 'package:trainee/modules/features/splash/binddings/splash_bindding.dart';
import 'package:trainee/modules/features/splash/views/ui/splash_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.splash,
      page: () => const SplashView(),
      binding: SplashBindding(),
    ),

    GetPage(
      name: MainRoute.signIn,
      page: () => const SignInView(),
      binding: SignInBindding(),
    ),

    GetPage(
      name: MainRoute.noConnection,
      page: () => const NoConnectionView(),
    ),

    GetPage(
      name: MainRoute.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgorPasswordBindding(),
    ),

    GetPage(
      name: MainRoute.opt,
      page: () => const OtpView(),
      binding: OtpBindding(),
    ),

    GetPage(
      name: MainRoute.home,
      page: () => const HomeView(),
      binding: HomeBindding(),
      children: [
        GetPage(
          name: MainRoute.foodDetail,
          page: () => const FoodDetailView(),
          binding: DetailFoodBindding(),
        ),

        GetPage(
          name: MainRoute.order,
          page: () => const OrderView(),
          binding: OrderBindding(),
          children: [
            GetPage(
              name: MainRoute.orderDetail,
              page: () => const DetailOrderView(),
              binding: DetailOrderBindding(),
            ),
          ],
        ),

        GetPage(
            name: MainRoute.checkout,
            page: () => const CheckoutView(),
            binding: CheckoutBindding()
        ),

        GetPage(
            name: MainRoute.profile,
            page: () => const ProfileView(),
            binding: ProfileBindding()
        ),
      ]
    ),
  ];
}
