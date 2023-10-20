import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class SaveIcon extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const SaveIcon({Key? key, this.color, this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        AppAssets.saveIcon,
        color: color ?? AppColorsController().iconColor,
        width: width ?? 0.06.sw,
        height: height ?? 0.06.sw,
        fit: BoxFit.fill,
      ),
    );
  }
}
