import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/duration_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';

class AppLoaderWidget extends StatelessWidget {
  final String? loadingComment;
  final LoaderSize loaderSize;

  const AppLoaderWidget(
      {Key? key, this.loadingComment, this.loaderSize = LoaderSize.Normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasComment = !(loadingComment == null || loadingComment!.isEmpty);
    SpinKitFoldingCube loader;
    if (loaderSize == LoaderSize.Small) {
      loader = SpinKitFoldingCube(
        duration:
            Duration(milliseconds: DurationConsts.LONG_ANIMATION_DURATION),
        color: DIManager.findDep<AppColorsController>().primaryColor,
        size: 0.06.sw,
      );
    } else {
      loader = SpinKitFoldingCube(
        duration:
            Duration(milliseconds: DurationConsts.LONG_ANIMATION_DURATION),
        color: DIManager.findDep<AppColorsController>().primaryColor,
      );
    }
    if (hasComment) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: Dimens.cardInternalPadding,
                constraints: BoxConstraints(
                  minWidth: 0.4.sw,
                ),
                decoration: BoxDecoration(
                    // boxShadow: [
                    //   AppStyle.normalShadow..color.withOpacity(0.1)
                    // ],
                    color: Colors.white.withOpacity(0.8),
                    borderRadius:
                        BorderRadius.circular(Dimens.cardBorderRadius)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VerticalPadding(2.0),
                    Container(
                      child: loader,
                    ),
                    VerticalPadding(4.0),
                    if (hasComment)
                      Text(
                        loadingComment ?? '',
                        style: AppStyle.titleStyle.copyWith(
                            color:
                                DIManager.findDep<AppColorsController>().primaryColor),
                      )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalPadding(2.0),
                  loader,
                  VerticalPadding(4.0),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}

enum LoaderSize {
  Small,
  Normal,
}
