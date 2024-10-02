import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;
  final EdgeInsetsGeometry? margin;
  const CustomDivider({super.key, required this.thickness, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thickness,
      color: Colors.black45,
      margin: margin,
    );
  }
}