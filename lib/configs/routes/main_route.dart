abstract class MainRoute {
  /// Initial
  static const String splash = '/';
  static const String opt = '/otp';
  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String catalog = '/catalog';
  static const String noConnection = '/no-connection';
  static const String forgotPassword = '/forgot-password';

  // page-view //
  // static const String listHome = '/list';
  // static const String order = '/order';
  static const String orderDetail = '/home/order/:orderId';
  static const String menuDetail = '/home/menu/:menuId';
}