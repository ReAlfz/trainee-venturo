import 'package:get/get.dart';
import 'package:trainee/modules/features/profile/controllers/profile_controller.dart';

class ProfileBindding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}