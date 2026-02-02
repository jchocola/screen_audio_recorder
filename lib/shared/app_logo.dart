import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 25});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(AppConstant.appLogoUrl));
  }
}
