import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/dimens.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';

class NewButton extends StatelessWidget {

  NewButton({required this.text,this.textStyle,this.textPadding,required this.onPressed,this.isLoading = false});

  final String text;
  final EdgeInsets? textPadding;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          side: BorderSide(color: AppColorsController().lightRed),
          backgroundColor: AppColorsController().darkRed,
          foregroundColor: AppColorsController().lightRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
        ),
        child: Padding(
          padding: textPadding ?? const EdgeInsets.symmetric(horizontal: 48),
          child: isLoading?  Container(
              width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().white,strokeWidth: 1.5,)): Text(
            text,
            style: textStyle ??
                AppStyle.smallTitleTextStyle.copyWith(
                    color: AppColorsController().white,
                    fontWeight: AppFontWeight.bold,
                    overflow: TextOverflow.ellipsis),),
        ));
  }
}
