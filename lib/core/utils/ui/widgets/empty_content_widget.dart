import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EmptyContentWidget extends StatelessWidget {
  final String? message;
  final String? imagePath;
  final double? width;
  final double? fontSize;
  final bool isSvg;
  final Color? color;

  const EmptyContentWidget(
      {Key? key,
      this.message,
      this.imagePath,
      this.width,
      this.fontSize,
      this.color,
      this.isSvg = true, fontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!isSvg)
                Image.asset(
                  this.imagePath == null || this.imagePath!.isEmpty
                      ? "AppAssets.empty_image1"
                      : this.imagePath!,
                  width: this.width ?? 0.6.sw,
                  color:color,
                  fit: BoxFit.fitWidth,
                )
              else
                SvgPicture.asset(
                  this.imagePath == null || this.imagePath!.isEmpty
                      ? "AppAssets.empty_image1"
                      : this.imagePath!,
                  fit: BoxFit.fitWidth,
                  color: color,
                  width: this.width ?? 0.5.sw,
                )
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            this.message ?? translate('no_data'),
            style: TextStyle(
              color: DIManager.findDep<AppColorsController>().greyTextColor,
                fontSize: this.fontSize ?? AppFontSize.fontSize_16),
          )
        ],
      ),
    );
  }
}
