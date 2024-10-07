import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../configs/routes/main_route.dart';
import '../../../../utils/services/location_sevice.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();

  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  Future<void> getLocation() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(Container(), barrierDismissible: false);
    }

    try {
      statusLocation.value = 'loading';
      final locationResult = await LocationService.getCurrentPosition();

      if (locationResult.success) {
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(MainRoute.home);
      } else {
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }

  @override
  void onReady() {
    super.onReady();

    getLocation();
    LocationService.streamService.listen((event) => getLocation());
  }
}