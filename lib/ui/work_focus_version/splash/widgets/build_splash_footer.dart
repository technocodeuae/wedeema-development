import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/custom_icons.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class BuildSplashFooter extends StatelessWidget {
  const BuildSplashFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 270,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/splash/splash_user.png",
              width: 220,
              height: 220,
            ),
          ),
          Positioned(
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.string(
                  CustomIcons.splash_msg.replaceAll(
                    "#ee3e43",
                    DIManager.findDep<AppColorsController>().primaryColorStr,
                  ),
                  height: 105,
                  width: 105,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    translate("welcomeSaeed"),
                  style: AppStyle.defaultStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
