import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class FaceBookIcon extends StatelessWidget {
  final Color? color;
  final double? width;

  const FaceBookIcon({Key? key, this.color, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        AppAssets.facebookIcons,
        color: color ?? AppColorsController().iconColor,
        width: width ?? 0.06.sw,
        height: width ?? 0.06.sw,
        fit: BoxFit.fill,
      ),
    );
  }
}
