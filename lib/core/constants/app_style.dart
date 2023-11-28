import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';

class AppStyle {
  static BoxDecoration formFieldDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(Dimens.textFormBorder),
      border: Border.all(
        color: AppColorsController().borderColor,
        width: 0.2,
      ),
      color: AppColorsController().containerPrimaryColor,
      // boxShadow: [
      //   BoxShadow(
      //       spreadRadius: 1,
      //       blurRadius: 7,
      //       color: Colors.grey.shade300.withOpacity(0.9),
      //       offset: Offset(0.0, 2.5))
      // ]
       );

  static BoxShadow get iconShadow => BoxShadow(
      offset: Offset(2, 8.0),
      color: DIManager.findDep<AppColorsController>()
          .primaryColor
          .withOpacity(0.08),
      spreadRadius: 0.0,
      blurRadius: 0.0);

  static BoxShadow coloredShadow(Color color) => BoxShadow(
      offset: Offset(0, 1), color: color, spreadRadius: 1.0, blurRadius: 1.0);

  static BoxShadow get normalShadow => BoxShadow(
      color: Colors.grey.shade300,
      blurRadius: 4,
      spreadRadius: 1.0,
      offset: Offset(0, 1));

  static BoxShadow get bottomSheetShadow => BoxShadow(
        color: Color(0xFF000029).withOpacity(0.15),
        blurRadius: 6,
        spreadRadius: 0,
        offset: Offset(0, -5),
      );

  static BoxShadow get mediumShadow => BoxShadow(
      color: Colors.grey.shade400,
      blurRadius: 4,
      spreadRadius: 1.0,
      offset: Offset(0, 1));

  static BoxShadow get normalIconShadow => BoxShadow(
        color: Colors.grey.shade300,
        offset: Offset(0, 0),
        spreadRadius: 1.5,
        blurRadius: 6.0,
      );

  static InputDecoration inputDecoration(
      {String? hintText,
      String? labelText,
      FocusNode? focusNode,
      Widget? suffixIcon,
      bool? obscuring,
      Color? labelColor,
      Function? onObscurePressed}) {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
        hintStyle: TextStyle(
            fontSize: AppFontSize.fontSize_14,
            color: labelColor ??
                DIManager.findDep<AppColorsController>().greyTextColor),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
            color: focusNode?.hasFocus == true
                ? DIManager.findDep<AppColorsController>().primaryColor
                : DIManager.findDep<AppColorsController>().greyTextColor),
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: obscuring != null
            ? IconButton(
                icon: Icon(
                  obscuring ? Icons.visibility : Icons.visibility_off,
                  color: DIManager.findDep<AppColorsController>().red,
                ),
                onPressed: () {
                  onObscurePressed!();
                })
            : suffixIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.textFormBorder)),
        focusColor: DIManager.findDep<AppColorsController>().primaryColor,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.textFormBorder),
            borderSide: BorderSide(
                color: DIManager.findDep<AppColorsController>().primaryColor,
                width: 1.5.w)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.textFormBorder),
            borderSide: BorderSide(color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.textFormBorder),
            borderSide: BorderSide(color: Colors.transparent)));
  }

  static InputDecoration inputDecorationSearch({
    String? hintText,
    TextStyle? hintStyle,
    required FocusNode searchFocusNode,
  }) =>
      InputDecoration(
        hintStyle: hintStyle ??
            TextStyle(
                color: DIManager.findDep<AppColorsController>().greyTextColor),
        hintText: hintText ?? translate('search_here'),
        //labelText: labelText,
        focusColor: DIManager.findDep<AppColorsController>().primaryColor,
        hoverColor: DIManager.findDep<AppColorsController>().primaryColor,
        labelStyle: TextStyle(
            color: searchFocusNode.hasFocus == true
                ? DIManager.findDep<AppColorsController>().primaryColor
                : DIManager.findDep<AppColorsController>().greyTextColor),
        alignLabelWithHint: true,
        filled: true,
        isCollapsed: true,
        fillColor: Colors.white,
        // contentPadding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
        focusedBorder: InputBorder.none,
        border: InputBorder.none,

        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        //   borderSide: BorderSide(color: Colors.grey),
        // ),
      );

  static InputDecoration inputDecorationOutlined({
    String? hintText,
    String? labelText,
    FocusNode? focusNode,
    Widget? suffixIcon,
    Color? borderColor,
    Color? labelColor,
    double opacity = 1.0,
    double borderSideWidth = 1,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
        color: labelColor ?? DIManager.findDep<AppColorsController>().red,
        fontWeight: AppFontWeight.bold,
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: focusNode?.hasFocus == true
            ? DIManager.findDep<AppColorsController>().primaryColor
            : labelColor ??
                DIManager.findDep<AppColorsController>()
                    .red
                    .withOpacity(opacity),
        fontWeight: AppFontWeight.bold,
      ),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          width: borderSideWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: borderColor != null
              ? borderColor.withOpacity(opacity)
              : Colors.grey.withOpacity(opacity),
          width: borderSideWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findDep<AppColorsController>().primaryColor,
          width: borderSideWidth,
        ),
      ),
    );
  }

  static InputDecoration inputDecorationWithOulLine({
    String? hintText,
    String? labelText,
    FocusNode? focusNode,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
          color: DIManager.findDep<AppColorsController>().greyTextColor),
      hintText: labelText,
      //labelText: labelText,
      focusColor: DIManager.findDep<AppColorsController>().primaryColor,
      hoverColor: DIManager.findDep<AppColorsController>().primaryColor,
      labelStyle: TextStyle(
          color: focusNode?.hasFocus == true
              ? DIManager.findDep<AppColorsController>().primaryColor
              : DIManager.findDep<AppColorsController>().greyTextColor),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findDep<AppColorsController>().primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(
          color: DIManager.findDep<AppColorsController>().primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.textFormBorder),
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  AppStyle._();

  static String? fontFamily;

  static TextStyle errorMessageStyle = TextStyle(
    fontSize: AppFontSize.fontSize_12,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    height: 2.sp,
  );

  static TextStyle get smallTitleTextStyle => TextStyle(
        fontSize: AppFontSize.fontSize_13,
        color: DIManager.findDep<AppColorsController>().textPrimaryColor,
      );

  static TextStyle get smallTextStyle => TextStyle(
    fontSize: AppFontSize.fontSize_14,fontWeight: FontWeight.w800,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
  );

  // 10
  static TextStyle lightSubtitle = TextStyle(
    fontSize: AppFontSize.fontSize_10,
    fontWeight: AppFontWeight.light,
    color: DIManager.findDep<AppColorsController>().greyTextColor,
  );

  // 12
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppFontSize.fontSize_12,
        color: DIManager.findDep<AppColorsController>().textPrimaryColor,
        // height: AppFont.fontHeight,
      );

  // 16
  static TextStyle titleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    // height: AppFont.fontHeight,
  );

  // 24
  static TextStyle veryBigTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_22,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
  );


  // 18
  static TextStyle bigTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_18,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
  );

  // 20
  static TextStyle bigTitleStyle2 = TextStyle(
    fontSize: AppFontSize.fontSize_20,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
  );


  // 16
  static TextStyle midTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    fontWeight: FontWeight.w400,
  );


  // 18
  static TextStyle namePostTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().black,
    fontWeight: FontWeight.w600,
  );

  // 14
  static TextStyle smallTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_14,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    fontWeight: FontWeight.w400,
  );

  // 11
  static TextStyle verySmallTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_11,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    fontWeight: FontWeight.w400,
  );

  // 9
  static TextStyle tinySmallTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_9,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    fontWeight: FontWeight.w400,
  );

  // 8
  static TextStyle tinyTitleStyle = TextStyle(
    fontSize: AppFontSize.fontSize_8,
    color: DIManager.findDep<AppColorsController>().textPrimaryColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle tabBarLabelStyle = TextStyle(
    fontSize: ScreenHelper.scaleText(51.sp),
    color: DIManager.findDep<AppColorsController>().primaryColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle tabBarUnselectedLabelStyle = TextStyle(
    fontSize: AppFontSize.fontSize_12,
    color: DIManager.findDep<AppColorsController>().greyTextColor,
  );

  static TextStyle appbarStyle = TextStyle(
    fontSize: AppFontSize.fontSize_16,
    color: DIManager.findDep<AppColorsController>().black,
    fontWeight: FontWeight.bold,
  );

  static double get appbarElevation => 4.sp;
}
