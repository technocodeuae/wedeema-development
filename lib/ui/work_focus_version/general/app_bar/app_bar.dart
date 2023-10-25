import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';

class AppBarWidget extends StatelessWidget {
  final Widget? child;
  final String? name;
  final bool flip;

  const AppBarWidget({Key? key, this.child, this.name, this.flip = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: 12.sp,),
        Container(
          height: 85.sp,
          decoration: ThemeProvider().appMode == "light"
              ? BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.appBarBackgroundImage),
                      fit: BoxFit.fill),
                )
              : BoxDecoration(
                  color: AppColorsController().white,
                ),
          child: Padding(
            padding: EdgeInsets.only(top: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                      padding:name=='search'?EdgeInsets.symmetric(horizontal: 15.sp): EdgeInsets.symmetric(horizontal: 34.sp),
                      child: child ?? Container()),
                ),
                name=='search'?Container(): Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      name ?? "",
                      style: AppStyle.smallTitleStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: AppFontWeight.bold,
                        fontSize: 22.sp,
                      ),maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class AppBarForPages extends StatelessWidget {
  final String? name;

  const AppBarForPages({Key? key, this.name,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: 12.sp,),
        Container(
          height: 85.sp,
          decoration: ThemeProvider().appMode == "light"
              ? BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.appBarBackgroundImage),
                fit: BoxFit.fill),
          )
              : BoxDecoration(
            color: AppColorsController().white,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.sp),
            child: Center(
              child: Text(
                name ?? "",
                style: AppStyle.smallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.bold,
                  fontSize:AppFontSize.fontSize_20,
                ),maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}





/*

Code with Transform.flip



Transform.flip(
      flipX: flip,
      flipY: flip,
      child: Container(
        height: 85.sp,
        decoration: ThemeProvider().appMode == "light"
            ? BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.appBarBackgroundImage),
                    fit: BoxFit.fill),
              )
            : BoxDecoration(
                color: AppColorsController().white,
              ),
        child: Transform.flip(
          flipX: flip,
          flipY: flip,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.sp),
                      child: child ?? Container()),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      name ?? "",
                      style: AppStyle.smallTitleStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: AppFontWeight.bold,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
 */