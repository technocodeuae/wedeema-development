import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.8.w,
      endIndent: 7.5.w,
      indent: 7.5.w,
      thickness: 0.5.w,
      color: DIManager.findDep<AppColorsController>().red,
    );
  }
}
