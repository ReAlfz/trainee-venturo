import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/catalog/binddings/catalog_bindding.dart';
import 'package:trainee/modules/features/catalog/views/ui/catalog_view.dart';
import 'package:trainee/modules/features/forgot_password/binddings/forgot_password_bindding.dart';
import 'package:trainee/modules/features/forgot_password/binddings/otp_bindding.dart';
import 'package:trainee/modules/features/forgot_password/views/ui/forgot_password_view.dart';
import 'package:trainee/modules/features/forgot_password/views/ui/otp_view.dart';
import 'package:trainee/modules/features/list/binddings/list_bindding.dart';
import 'package:trainee/modules/features/list/views/ui/list_item_view.dart';
import 'package:trainee/modules/features/error_handler//views/ui/NoConnectionView.dart';
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
      name: MainRoute.list,
      page: () => const ListItemView(),
      binding: ListBinddings(),
    ),

    GetPage(
      name: MainRoute.catalog,
      page: () => const CatalogView(),
      binding: CatalogBindding(),
    ),
  ];
}
