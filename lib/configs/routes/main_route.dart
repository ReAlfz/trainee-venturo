abstract class MainRoute {
  /// Initial
  static const String splash = '/';
  static const String opt = '/otp';
  static const String signIn = '/signIn';
  static const String noConnection = '/no-connection';
  static const String forgotPassword = '/forgot-password';

  static const String home = '/home';
  // start children of home //
  static const String lobby = '/lobby';
  // start children of lobby //
  static const String foodDetail = '/food/:idMenu';
  // end children of lobby //

  static const String order = '/order';
  // start children of order //
  static const String orderDetail = '/:orderId';
  // end children of order //

  static const String checkout = '/checkout';
  static const String profile = '/profile';
  // end children of home //
}