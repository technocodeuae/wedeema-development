 import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_font.dart';

import '../../ui/work_focus_version/general/buttons/app_button.dart';

import '../utils/localization/app_localizations.dart';
import 'app_colors.dart';
import 'app_style.dart';

Widget buttonBuild({String? text, dynamic Function()? onPressed,double horizontal =24}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal,
    ),
    child: AppButton(
      buttonColor: AppColorsController().buttonRedColor,width: 100,
      height: 48,
      child: Center(
        child: Text(
          translate(text!),
          style: AppStyle.lightSubtitle.copyWith(
              color: AppColorsController().white,
              fontWeight: FontWeight.w800,
              fontSize: AppFontSize.fontSize_20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}