import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';

class ItemProfileCardWidget extends StatefulWidget {
  final String title;
  final String? icon;
  final bool? isProfile;
  final VoidCallback onPressed;
  final bool isLoading;

  const ItemProfileCardWidget(
      {required this.title, this.icon, required this.onPressed, this.isProfile = false,this.isLoading =false});

  @override
  State<ItemProfileCardWidget> createState() => _ItemProfileCardWidgetState();
}

class _ItemProfileCardWidgetState extends State<ItemProfileCardWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 6.sp),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColorsController().containerPrimaryColor,
            border: Border.all(
              width: 0.2,
              // assign the color to the border color
              color: AppColorsController().borderColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.containerBorderRadius),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isProfile == true ?
              (DIManager.findDep<SharedPrefs>().getImageProfile() !=
                  null &&
                  DIManager.findDep<SharedPrefs>()
                      .getImageProfile()!
                      .isNotEmpty)
                  ? Container(
                width: 36.sp,
                height: 36.sp,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    AppConsts.IMAGE_URL +
                        DIManager.findDep<SharedPrefs>()
                            .getImageProfile()
                            .toString(),
                  ),
                  backgroundColor: Colors.transparent,
                ),
              )
                  : Container(
                height: 35.sp,
                width: 35.sp,

                child: SvgPicture.asset(
                  widget.icon!,
                  color: AppColorsController().iconColor,

                ),
                // Icons.arrow_back_ios_sharp,
                // color: AppColors.black,
                // size: 20,
              ):Container(
                height: 35.sp,
                width: 35.sp,

                child: SvgPicture.asset(
                  widget.icon!,
                  color: AppColorsController().iconColor,

                ),
                // Icons.arrow_back_ios_sharp,
                // color: AppColors.black,
                // size: 20,
              ),
              SizedBox(
                width: 12.sp,
              ),
              Container(
                child: Text(
                  widget.title,
                  style: AppStyle.smallTitleTextStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              widget.isLoading? SizedBox(width: 20.sp,):Container(),
              widget.isLoading?  Container(
                  width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().buttonRedColor,strokeWidth: 1.5,)):Container(),
              Spacer(),
              Container(
                height: 20.sp,
                width: 20.sp,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.downArrowIcon),
                      fit: BoxFit.fill),
                ),


                // Icons.arrow_back_ios_sharp,
                // color: AppColors.black,
                // size: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
