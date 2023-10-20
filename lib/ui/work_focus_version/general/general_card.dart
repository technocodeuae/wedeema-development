import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';

class GeneralCard extends StatelessWidget {
  final Widget child;
  final bool withPadding;
  final double? borderRadius;

  const GeneralCard(
      {Key? key,
      this.withPadding = true,
      required this.child,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: withPadding
          ? EdgeInsets.symmetric(horizontal: 0.045.sw, vertical: 0.02.sh)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
          color: AppColorsController().white,
          borderRadius:
              BorderRadius.circular(borderRadius ?? Dimens.cardBorderRadius),
          boxShadow: [AppStyle.normalShadow]),
      child: child,
    );
  }
}
