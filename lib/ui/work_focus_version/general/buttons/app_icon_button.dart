import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';

class AppIconButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? childPadding;
  final BoxShadow? shadow;
  final double? width;
  final Function()? onPressed;

  const AppIconButton(
      {Key? key,
      required this.child,
      this.width,
      required this.onPressed,
      this.childPadding,
      this.shadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconWidth = 0.09.sw;

    return Container(
      width: width ?? iconWidth,
      height: width ?? iconWidth,
      decoration: BoxDecoration(
          color: DIManager.findDep<AppColorsController>().white,
          boxShadow: [shadow ?? AppStyle.iconShadow],
          borderRadius: BorderRadius.circular(iconWidth)),
      child: TextButton(
        style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(iconWidth)),
        ),
        onPressed:onPressed,
        child: Container(
          padding: childPadding ?? EdgeInsets.all(0.015.sw),
          child: child,
        ),
      ),
    );
  }
}
