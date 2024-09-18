import 'package:flutter/material.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.img_logo),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
