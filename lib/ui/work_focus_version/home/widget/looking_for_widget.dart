import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/core/constants/app_colors.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../models/looking_model.dart';

class LookingForWidget extends StatelessWidget {
  final CategoriesEntity? data;
  final double? height;
  final Function()? onPressed;
  final double? width;

  LookingForWidget({Key? key, this.data, this.width, this.height, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 71.sp,
      width: width ?? 71.sp,
      decoration: BoxDecoration(
        border: Border.all(color: AppColorsController().black, width: 0.2.sp),
        color: AppColorsController().white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.sp),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            foregroundColor: AppColorsController().scaffoldBGColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              data!.icon!.toString().endsWith(".svg") == true
                  ? SvgPicture.network(
                      AppConsts.IMAGE_URL + data!.icon!,
                      width: 34.sp,
                      height: 34.sp,
                placeholderBuilder: (BuildContext context) => Container(
                  width: 18.sp,height: 18.sp,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.2,
                    color: AppColorsController().buttonRedColor,),
                )

              )
                  : Image.network(
                      AppConsts.IMAGE_URL + data!.icon!,
                      width: 34.sp,
                      height: 34.sp,errorBuilder: (context, error, stackTrace){
                        return Container();
              },
                    ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                data?.title.toString() ?? '',
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.bold,fontSize: AppFontSize.fontSize_12
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
