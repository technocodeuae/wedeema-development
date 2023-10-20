import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';

class Dimens {
  Dimens._();

  static EdgeInsets cardInternalPadding = EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w);

  // ignore: non_constant_identifier_names
  static double defaultBorderWidth = ScreenHelper.fromWidth55(0.35);

  static double cardBorderRadius = 10.w;
  static double bottomSheetBorderRadius = 15.w;

  static double textFormBorder = 20.w;
  static double defaultBorderRadius = 12.w;
  static double dialogBorderRadius = 15.w;
  static double containerBorderRadius = 20.w;

  static double bigBorderRadius = 15.w;
  static final sheetHeaderPadding = EdgeInsets.symmetric(horizontal: 20.w,vertical: 14.h);
  static final horizontalPadding1 = EdgeInsets.symmetric(horizontal: 20.w);
  static final horizontalPadding2 = EdgeInsets.symmetric(horizontal: ScreenHelper.fromWidth55(10.0.sp));
  static final defaultPageHorizontalPadding = EdgeInsets.symmetric(horizontal: ScreenHelper.fromWidth55(6.0.sp));
  static final defaultPageHorizontalPaddingSmall = EdgeInsets.symmetric(horizontal: ScreenHelper.fromWidth55(4.0.sp));

  static double get appbarBorderRadius => 0.0;
}
