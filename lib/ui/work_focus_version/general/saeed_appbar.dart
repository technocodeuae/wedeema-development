import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../../../core/utils/string_utils/string_utils.dart';

class SaeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SaeedAppBar({
    Key? key,
    this.title,
    this.actions,
    this.withPaddingOnActions = false,
    this.withBack = true,
    this.customPreferredSize,
    this.onBackPressed,
    this.leading,
    this.bottom,
    this.isTitleCentered = true,
  }) : super(key: key);

  final String? title;
  final List<Widget>? actions;
  final bool withPaddingOnActions;
  final bool withBack;
  final Size? customPreferredSize;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final Function()? onBackPressed;
  final bool isTitleCentered;

  @override
  Size get preferredSize =>
      customPreferredSize ??
      Size(
          double.maxFinite,
          max(
              AppBar(
                bottom: bottom,
              ).preferredSize.height,
              ScreenHelper.fromHeight55(8)));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: DIManager.findDep<AppColorsController>().primaryColor,
      bottom: bottom,
      actions: withPaddingOnActions == true && actions != null
          ? [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: actions!,
              ),
              SizedBox(
                width: 23.w,
              )
            ]
          : [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: actions ?? [],
              )
            ],
      centerTitle: isTitleCentered,
      backgroundColor: AppColorsController().white,
      shadowColor: DIManager.findDep<AppColorsController>().primaryColor.withOpacity(0.15),
      elevation: AppStyle.appbarElevation,
      // flexibleSpace: Image.asset(
      //   AppAssets.home_appbar_mask,
      //   width: ScreenHelper.width55,
      //   fit: BoxFit.fitWidth,
      //   color: DIManager.findDep<AppColorsController>().primaryColor,
      // ),
      title: title != null
          ? Text(
              title!.toTitleCase(),
              style: AppStyle.appbarStyle,
            )
          : null,
      leading: withBack
          ? InkWell(
              onTap: onBackPressed ??
                  () {
                      DIManager.findNavigator().pop();
                  },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenHelper.fromWidth55(5), vertical: ScreenHelper.fromHeight55(0.5)),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: DIManager.findDep<AppColorsController>().primaryColor,
                  size: ScreenHelper.fromWidth55(6.0),
                ),
              ),
            )
          : leading,
    );
  }
}
