import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class BackIcon extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const BackIcon({Key? key, this.color, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: translate('back'),
      child: Transform.flip(
        flipX: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_EN,
        child: SvgPicture.asset(
          DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR
              ? AppAssets.backRightIcons
              : AppAssets.backIcons,
          color: color ?? AppColorsController().iconColor,
          width: 0.08.sw,
          // width: width ?? 0.06.sw,
          height: 0.08.sw,
          //  height: height ?? 0.06.sw,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
