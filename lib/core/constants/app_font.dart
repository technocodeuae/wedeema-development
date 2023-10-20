import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';

class AppFont {
  AppFont._();

  static double fontHeight = 1.2;

  static TextTheme getTextTheme(TextTheme textTheme) =>
      GoogleFonts.cairoTextTheme(textTheme.copyWith(
        bodyText1: AppStyle.defaultStyle,
        bodyText2: AppStyle.defaultStyle,
      ));

  static TextStyle get textStyle => GoogleFonts.cairo();
}

class AppFontSize {
  AppFontSize._();

  // static double get _scaleFactor => 0.65;
  static double get _scaleFactor => 0.95;

  /// Font sizes
  static double get fontSize_6 => 6.sp;
  static double get fontSize_7 => 7.sp;
  static double get fontSize_8 => 8.sp;

  static double get fontSize_9 => 9.sp;

  static double get fontSize_10 => 10.sp;
  static double get fontSize_11 => 11.sp;
  static double get fontSize_12 => 12.sp;
  static double get fontSize_13 => 13.sp;
  static double get fontSize_14 => 14.sp;
  static double get fontSize_16 => 16.sp;
  static double get fontSize_18 => 18.sp;
  static double get fontSize_20 => 20.sp;
  static double get fontSize_22 => 22.sp;
  static double get fontSize_24 => 24.sp;
  static double get fontSize_40 => 40.sp;
}

/*

class AppFontSize {
  AppFontSize._();

  // static double get _scaleFactor => 0.65;
  static double get _scaleFactor => 0.95;

  /// Font sizes
  static double get fontSize_6 => 6 * _scaleFactor;
  static double get fontSize_7 => 7 * _scaleFactor;
  static double get fontSize_8 => 8 * _scaleFactor;

  static double get fontSize_9 => 9 * _scaleFactor;

  static double get fontSize_10 => 10 * _scaleFactor;

  static double get fontSize_11 => 11 * _scaleFactor;

  static double get fontSize_12 => 12 * _scaleFactor;

  static double get fontSize_13 => 13 * _scaleFactor;

  static double get fontSize_14 => 14 * _scaleFactor;

  static double get fontSize_16 => 16 * _scaleFactor;

  static double get fontSize_18 => 18 * _scaleFactor;

  static double get fontSize_20 => 20 * _scaleFactor;

  static double get fontSize_22 => 22 * _scaleFactor;

  static double get fontSize_24 => 24 * _scaleFactor;

  static double get fontSize_40 => 40 * _scaleFactor;
}

 */






class AppFontWeight {
  AppFontWeight._();

  static FontWeight light = FontWeight.w300;
  static FontWeight midLight = FontWeight.w400;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight midBold = FontWeight.w500;
  static FontWeight regular = FontWeight.normal;
  static FontWeight bold = FontWeight.bold;
}

class AppFontStyle {
  static TextStyle get normalTitle => TextStyle(
      color: DIManager.findDep<AppColorsController>().black,
      fontWeight: AppFontWeight.bold,
      fontSize: AppFontSize.fontSize_16);

  static TextStyle get formFieldStyle => TextStyle(
      color: DIManager.findDep<AppColorsController>().black,
      fontWeight: AppFontWeight.regular,
      fontSize: AppFontSize.fontSize_13);
}
