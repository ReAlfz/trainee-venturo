abstract class MainRoute {
  /// Initial
  static const String splash = '/';
  static const String opt = '/otp';
  static const String signIn = '/signIn';
  static const String noConnection = '/no-connection';
  static const String forgotPassword = '/forgot-password';

  static const String home = '/home';
  static const String location = '/location';
  // start children of home //
  static const String food = '/food';
  static const String promo = '/food/promo';
  static const String foodDetail = '/food/detail-menu';

  static const String order = '/order';
  static const String orderDetail = '/order/detail-order';

  static const String checkout = '/checkout';
  static const String profile = '/profile';
  // end children of home //
}