import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/profile/repositories/profile_repository.dart';
import 'package:trainee/shared/widgets/image_picker_dialog.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerify = false.obs;

  File? get imageFile => _imageFile.value;
  late final ProfileRepository repository;

  @override
  void onInit() async {
    await getDeviceInformation();
    repository = ProfileRepository();
    super.onInit();
  }

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
                lockAspectRatio: true
            ),
            IOSUiSettings(
              aspectRatioPickerButtonHidden: true,
              aspectRatioLockEnabled: true,
            ),
          ],
        );

        if (croppedFile != null) {
          _imageFile.value = File(croppedFile.path);
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
}