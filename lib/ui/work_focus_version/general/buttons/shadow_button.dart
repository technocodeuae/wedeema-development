import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/duration_consts.dart';

class ShadowButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Function onPressed;
  final bool isActive;

  final Color? color;
  final bool? shadowColor;
  final EdgeInsets? padding;
  final Color? textColor;

  const ShadowButton(
      {Key? key,
      this.text,
      this.child,
      required this.onPressed,
      this.textColor,
      this.padding,
      this.color,
      this.isActive = true,
      this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration:
          Duration(milliseconds: DurationConsts.DEFAULT_ANIMATION_DURATION),
      opacity: isActive ? 1 : 0.3,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(0.05.sw),
            boxShadow: [
              shadowColor != null ? AppStyle.normalShadow : AppStyle.iconShadow
            ]),
        child: TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size.fromHeight(40),
            backgroundColor: color ?? Colors.white,
            padding:
            EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.006.sh),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.05.sw),
            ),
          ),
          onPressed: () {
            if (isActive) onPressed();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.05.sw),
            ),
            child: text == null
                ? child
                : Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child:Text(
                    text!,
                    style: AppStyle.titleStyle.copyWith(
                      color: textColor ?? Colors.white,
                      fontWeight: AppFontWeight.semiBold,
                    ),),
                  ),
          ),
        ),
      ),
    );
  }
}
