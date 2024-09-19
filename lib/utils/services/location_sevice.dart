import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  LocationService._();

  static Stream<ServiceStatus> streamService =
      Geolocator.getServiceStatusStream();

  static Future<LocationResult> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationResult.error(message: 'Location permission not granted'.tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationResult.error(message: 'Location permission not granted forever'.tr);
    }

    late Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }


    double distanceInMeter = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      AppCon.latitude,
      position.longitude,
    );
  }
}

class LocationResult {
  final bool success;
  final Position? position;
  final String? address;
  final String? message;

  LocationResult({
    required this.success,
    this.position,
    this.address,
    this.message,
  });

  factory LocationResult.success(
      {required Position position, required String address}) {
    return LocationResult(
      success: true,
      position: position,
      address: address,
    );
  }

  factory LocationResult.error({required String message}) {
    return LocationResult(
      success: false,
      message: message,
    );
  }
}
