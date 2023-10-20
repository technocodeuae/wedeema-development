import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../models/onboarding_slider_model.dart';
class PageViewSliderWidget extends StatefulWidget {
  const PageViewSliderWidget({Key? key}) : super(key: key);

  @override
  State<PageViewSliderWidget> createState() => _PageViewSliderWidgetState();
}

class _PageViewSliderWidgetState extends State<PageViewSliderWidget> {

  List<OnBoardingSlideModel> onBoardingSlideList = [

  ];

  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        onBoardingSlideList.length,
            (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 375.sp,
              height: 250.sp,
              child: Image.asset(
                onBoardingSlideList[index].imageUrl!,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 32.sp),
            Text(
              translate('${onBoardingSlideList[index].content}'),
              style: AppStyle.bigTitleStyle.copyWith(
                color: AppColorsController().primaryColor,
                fontWeight: AppFontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.sp),
            Text(
              translate('${onBoardingSlideList[index].slog}'),
              style: AppStyle.smallTitleStyle.copyWith(
                color: AppColorsController().darkGreyTextColor,
                fontWeight: AppFontWeight.midLight,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ));
    return  Column(
      children: [
        SizedBox(
          height: 170.sp,
        ),
        Expanded(
          child: PageView.builder(
            controller: controller,
            // itemCount: pages.length,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: CustomizableEffect(
            activeDotDecoration: _dotDecorationIndicator(
              width: 20.sp,
              height: 4.sp,
              color: AppColorsController().red,
              radius: 2.sp,
            ),
            dotDecoration: _dotDecorationIndicator(
              width: 10.sp,
              height: 4.sp,
              color: AppColorsController().greyIconColor,
              radius: 2.sp,
            ),
            spacing: 5.0.sp,
            inActiveColorOverride: (i) => AppColorsController().greyIconColor,
          ),
        ),
      ],
    );
  }
  _dotDecorationIndicator(
      {double? width, double? height, double? radius, Color? color}) {
    return DotDecoration(
      width: width!,
      height: height!,
      color: color!,
      borderRadius: BorderRadius.circular(radius!),
    );
  }
}
