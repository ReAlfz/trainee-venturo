import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/localization/localization.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/profile/repositories/profile_repository.dart';
import 'package:trainee/modules/features/profile/views/components/language_bottom_sheet.dart';
import 'package:trainee/modules/features/profile/views/components/profile_bottom_sheet.dart';
import 'package:trainee/shared/widgets/image_picker_dialog.dart';

import '../../../global_controllers/global_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerify = false.obs;

  File? get imageFile => _imageFile.value;
  RxString photoValue = 'no-data'.obs;
  late final ProfileRepository repository;

  Future<void> pickImage() async {
    try {
      ImageSource? imageSource = await Get.defaultDialog(
        title: '',
        titleStyle: const TextStyle(fontSize: 0),
        content: const ImagePickerDialog(),
      );

      if (imageSource == null) return;

      final pickFile = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 75,
      );

      if (pickFile != null) {
        _imageFile.value = File(pickFile.path);
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: _imageFile.value!.path,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper'.tr,
                toolbarColor: MainColor.primary,
                toolbarWidgetColor: MainColor.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            IOSUiSettings(
              aspectRatioPickerButtonHidden: true,
              aspectRatioLockEnabled: true,
            ),
          ],
        );

        if (croppedFile != null) {
          _imageFile.value = File(croppedFile.path);
          photoValue('data-file');
        }
      }
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      isVerify.value = true;
    }
  }

  Future<void> getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  void logout() async {
    repository.logoutUser();
    Get.offAllNamed(MainRoute.signIn);
  }

  RxString currentLang = Localization.currentLanguage.obs;

  Future<void> updateLanguage() async {
    String? language = await Get.bottomSheet(
      const LanguageBottomSheet(),
      isScrollControlled: true,
      backgroundColor: MainColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30.r),
      )),
    );

    if (language != null) {
      Localization.changeLocale(language);
      currentLang(language);
    }
  }

  final user = GlobalController.to.user.value!;
  RxString name = ''.obs;
  RxString date = ''.obs;
  RxString photo = 'no-data'.obs;
  RxString phone = ''.obs;
  RxString email = ''.obs;
  RxString pin = ''.obs;

  void changeUser({required String info}) async {
    switch (info) {
      case 'Name':
        name.value = await Get.bottomSheet(
          ProfileBottomSheet(hint: name.value, title: info),
        );
        break;

      case 'Email':
        email.value = await Get.bottomSheet(
          ProfileBottomSheet(hint: email.value, title: info),
        );
        break;

      case 'Phone':
        phone.value = await Get.bottomSheet(
          ProfileBottomSheet(hint: phone.value, title: info, numbers: true),
        );
        break;

      case 'Date':
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        DateTime? datetime = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime(DateTime.now().year - 21),
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime.now(),
        );
        if (datetime != null) date.value = dateFormat.format(datetime);
    }
  }

  @override
  void onInit() async {
    await getDeviceInformation();
    repository = ProfileRepository();

    name(user.nama);
    email(user.email);
    if (user.foto.isNotEmpty) {
      photo(user.foto);
      photoValue('data-api');
    }
    date('01/02/2003');
    phone('088888888888');
    pin(user.pin);
    super.onInit();
  }
}
