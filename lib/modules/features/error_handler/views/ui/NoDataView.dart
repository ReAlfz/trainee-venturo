import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bg_blank_connection),
            fit: BoxFit.fitHeight,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 35.h,
          horizontal: 35.h,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Oops Data tidak ditemukan, coba lagi nanti',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: MainColor.primary,
              ),
            ),

            SizedBox(height: 25.h),

            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                onPressed: () async {
                  await GlobalController.to.checkConnection(MainRoute.noConnection);
                  if (GlobalController.to.isConnect.value == true) {
                    Get.back();
                  }
                },

                child: Text(
                  'Coba Lagi',
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}