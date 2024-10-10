import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/hive_services.dart';

class ProfileRepository {
  Future<void> logoutUser() async {
    try {
      final dio = DioServices.dioCall(token: GlobalController.to.session.value);
      const url = 'auth/logout';

      await dio.get(url);
      GlobalController.to.session.value = '';
      GlobalController.to.user.value = null;

      LocalStorageService.logout();

    } catch (e, stacktrace) {
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }
}