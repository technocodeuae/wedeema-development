import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? childPadding;
  final BoxShadow? shadow;
  final double? width;
  final double? height;
  final Function()? onPressed;
  final Color? buttonColor;
  final double borderRadiusCircular ;

  const AppButton(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.buttonColor,
      required this.onPressed,
      this.childPadding,
      this.borderRadiusCircular=24 ,
      this.shadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconWidth = 332.sp;
    double iconHeight = 43.sp;

    return Container(
      width: width ?? iconWidth,
      height: height ?? iconHeight,
      decoration: BoxDecoration(
        color: buttonColor ??
            DIManager.findDep<AppColorsController>().buttonPrimaryColor,
        //  boxShadow: [shadow ?? AppStyle.iconShadow],
        border: Border.all(
          color: AppColorsController().borderColor,
          width: 0.2
        ),
        borderRadius: BorderRadius.circular(borderRadiusCircular),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onPressed,
        child: Container(
          padding: childPadding ?? EdgeInsets.all(0.015.sw),
          child: child,
        ),
      ),
    );
  }
}
