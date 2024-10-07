import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/sign_in/modules/user_model.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/session_services.dart';

class SignRepository {
  Future<bool> requestWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }

    return false;
  }

  Future<bool> requestAuth(
      {required String email, required String password}) async {
    final SessionService sessionService = SessionService();
    final dio = DioServices.dioCall();
    const url = '/auth/login';
    final data = {'email': email, 'password': password};

    try {
      final response = await dio.post(url, data: data);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        int statusCode = responseData['status_code'];
        if (statusCode == 200) {
          int userId = responseData['data']['user']['id_user'];
          UserModel userData = UserModel.fromJson(responseData['data']['user']);

          sessionService.saveUser('user', userData);
          GlobalController.to.user(userData);

          sessionService.saveToken('token', responseData['data']['token']);
          GlobalController.to.session.value = responseData['data']['token'];

          log('Login Success');
          log('Response body: ${response.data}');
          return true;
        }
      } else {
        log('Login failed with status: ${response.statusCode}');
        log('Response body: ${response.data}');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }

    return false;
  }

  Future<void> getUser(
      {required String token,
      required String userId,
      required SessionService sessionService}) async {
    final dio = DioServices.dioCall();
    const url = '/user/all';

    try {
      final response = dio.get(url);
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );
    }
  }
}
