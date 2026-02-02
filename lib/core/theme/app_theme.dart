import 'package:flutter/material.dart';
import 'package:recorder_app/core/theme/app_color.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.bgColor,

  colorScheme: ColorScheme.light(
    primary: AppColor.green,
    primaryContainer: AppColor.white,


    error: AppColor.red,
  ),
);
