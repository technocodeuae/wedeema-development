import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotWidget extends StatelessWidget {
  final double? radius;
  final Color? color;

  const DotWidget({Key? key, this.radius, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius ?? ScreenHelper.fromWidth55(2.5),
      height: radius ?? ScreenHelper.fromWidth55(2.5),
      decoration: BoxDecoration(
        color: color ?? DIManager.findDep<AppColorsController>().primaryColor,
        borderRadius: BorderRadius.circular(radius ?? ScreenHelper.fromWidth55(2.5)),
      ),
    );
  }
}

class DottedWidget extends StatelessWidget {
  final bool? isDotted;
  final Widget child;

  const DottedWidget({Key? key, this.isDotted, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -0.005.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: DotWidget(
              radius: ScreenHelper.fromWidth55(2.0),
            ),
          ),
        ),
      ],
    );
  }
}
