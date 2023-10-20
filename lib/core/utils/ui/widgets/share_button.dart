import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
class ShareAnimatedButton extends StatefulWidget {
  final String? text;
  final Color? color;
  final Image? leadingImage;
  final Color? textColor;
  final Widget? child;

  final VoidCallback? onPressed;

  final double? width;
  final double? height;
  final double? borderRadius;

  final bool isActive;
  final bool isBordered;
  final Color? borderColor;

  const ShareAnimatedButton(
      {Key? key,
        this.text,
        this.child,
        this.color,
        this.leadingImage,
        this.textColor,
        this.onPressed,
        this.width,
        this.height,
        this.borderRadius,
        this.isActive = true,
        this.isBordered = false,
        this.borderColor})
      : super(key: key);

  @override
  _ShareAnimatedButtonState createState() => _ShareAnimatedButtonState();
}

class _ShareAnimatedButtonState extends State<ShareAnimatedButton> {
  Duration _animationDuration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    // return Container();
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: 1.0,
      child: AnimatedContainer(
        duration: _animationDuration,
        width: this.widget.width,
        height: widget.height ?? ScreenHelper.fromHeight(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if(widget.isActive){
                    widget.onPressed!();
                  }
                },
                style: TextButton.styleFrom(
                  //minimumSize: Size.square(42.w),
                  backgroundColor: DIManager.findDep<AppColorsController>().primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                       17.w,
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                  child: Text(
                    translate('share'),
                    style: AppStyle.titleStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: DIManager.findDep<AppColorsController>().white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
