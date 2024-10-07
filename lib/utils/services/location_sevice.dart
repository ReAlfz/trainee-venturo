import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LocationService {
  LocationService._();

  static Stream<ServiceStatus> streamService =
      Geolocator.getServiceStatusStream();

  static Future<LocationResult> getCurrentPosition() async {
    try {
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
        position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      } catch (e) {
        return LocationResult.error(message: 'Location service not enabled'.tr);
      }

      String address = 'umahan Griya Shanta Permata, N-524, Mojolangu, Kec. Lowokwaru, Kota Malang, Jawa Timur 65141';

      List<Location> location;
      try {
        location = await locationFromAddress(address);
      } catch (e) {
        return LocationResult.error(message: 'Failed to get coordinates from address'.tr);
      }

      if (location.isEmpty) {
        return LocationResult.error(message: 'Address not found'.tr);
      }

      // double distanceInMeter = Geolocator.distanceBetween(
      //   position.latitude,
      //   position.longitude,
      //   -7.9467,
      //   112.6150,
      // );

      // if (distanceInMeter > 1000) {
      //   return LocationResult.error(message: 'Distance not close'.tr);
      // }

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        return LocationResult.error(message: 'Unknown location'.tr);
      }

      return LocationResult.success(
        position: position,
        address: [
          placemarks.first.name,
          placemarks.first.subLocality,
          placemarks.first.locality,
          placemarks.first.administrativeArea,
          placemarks.first.postalCode,
          placemarks.first.country,
        ].where((element) => element != null).join(', '),
      );
    } catch (e, stacktrace) {
      await Sentry.captureException(
        e,
        stackTrace: stacktrace,
      );

      return LocationResult.error(message: 'something error');
    }
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
