import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/location/controllers/location_controller.dart';
import 'package:app_settings/app_settings.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.bg_blank_connection),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Searching location...'.tr,
                style: Get.textTheme.titleLarge!
                    .copyWith(color: MainColor.black.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
              50.verticalSpacingRadius,
              Stack(
                children: [
                  Image.asset(
                    ImageConstant.bg_map,
                    width: 190.r,
                  ),
                  Padding(
                    padding: EdgeInsets.all(70.r),
                    child: Icon(
                      Icons.location_pin,
                      size: 50.r,
                    ),
                  ),
                ],
              ),
              50.verticalSpacingRadius,
              Obx(
                    () => ConditionalSwitch.single<String>(
                  context: context,
                  valueBuilder: (context) =>
                  LocationController.to.statusLocation.value,
                  caseBuilders: {
                    'error': (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocationController.to.messageLocation.value,
                          style: Get.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        24.verticalSpacingRadius,
                        ElevatedButton(
                          onPressed: () =>
                              AppSettings.openLocationSettings(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 2,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.settings,
                                color: MainColor.primary,
                              ),
                              16.horizontalSpaceRadius,
                              Text(
                                'Open settings'.tr,
                                style: Get.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    'success': (context) => Text(
                      LocationController.to.address.value!,
                      style: Get.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  },
                  fallbackBuilder: (context) => const CircularProgressIndicator(
                    color: MainColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}