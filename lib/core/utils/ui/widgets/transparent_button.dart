import 'package:flutter/material.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';

class TransparentButton extends StatefulWidget {
  final Widget? textChild;
  final String? text;
  final Function? onPressed;

  final Color? color;

  final double? width;

  final double? borderRadius;

  const TransparentButton(
      {Key? key,
      this.textChild,
      this.onPressed,
      this.color,
      this.width,
      this.borderRadius,
      this.text})
      : super(key: key);

  @override
  _TransparentButtonState createState() => _TransparentButtonState();
}

class _TransparentButtonState extends State<TransparentButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      height: ScreenHelper.fromHeight55(6.4),
      child: TextButton(
        onPressed: () {
          widget.onPressed!();
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? ScreenHelper.fromWidth55(10.0)),
              side: BorderSide(
                  color: widget.color ??
                      DIManager.findDep<AppColorsController>().primaryColor)),
        ),
        child: Center(
          child: widget.textChild ??
              Text(
                widget.text!,
                style: TextStyle(
                    color: DIManager.findDep<AppColorsController>().primaryColor,
                    fontSize: AppStyle.titleStyle.fontSize),
              ),
        ),
      ),
    );
  }
}
