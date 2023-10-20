import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wadeema/core/constants/app_assets.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/core/shared_prefs/shared_prefs.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/general/app_bar/app_bar.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/home_page.dart';

import '../../../core/constants/dimens.dart';
import '../../../core/utils/localization/app_localizations.dart';

class TourPage extends StatefulWidget {
  static const routeName = '/tour';

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  double _imageWidth = 220;
  double _imageHeight = 220;

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 22.0, color: Colors.black54);
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 37.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.only(left: 40, right: 40),
    );
    double _paddingTop = 300;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //       colors: [Color(0xffffccbd), Color(0xffe21d1d)],
              //       begin: const FractionalOffset(0.0, 0.0),
              //       end: const FractionalOffset(0.0, 1.0),
              //       stops: [0.0, 1.0],
              //       tileMode: TileMode.clamp)
              // ),
              ),
          IntroductionScreen(
            globalBackgroundColor: Colors.white,
            globalHeader: Stack(
              children: [
                AppBarWidget(
                  flip: true,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 108,left: 8,right: 8),
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        AppAssets.logoImage,
                        height: 150.sp,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            globalFooter: SizedBox(height: 20),
            pages: [
              PageViewModel(
                titleWidget: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 210.sp,),
                              Image.asset(
                                AppAssets.tour1,
                                height: _imageHeight,
                                width: _imageWidth,
                              ),
                            ],
                          )),
                    ),
                    _titleWidget('${translate('first_screen_title')}'),
                  ],
                ),
                body: '',
                // image: ,
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 210.sp,),
                              Image.asset(
                                AppAssets.tour2,
                                height: _imageHeight,
                                width: _imageWidth,
                              ),
                            ],
                          )),
                    ),
                    _titleWidget('${translate('second_screen_title')}'),
                  ],
                ),
                body: '',
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 210.sp,),
                              Image.asset(
                                AppAssets.tour3,
                                height: _imageHeight,
                                width: _imageWidth,
                              ),
                            ],
                          )),
                    ),
                    _titleWidget('${translate('third_screen_title')}'),
                  ],
                ),
                body: '',
                decoration: pageDecoration,
              ),
            ],
            onDone: () {
              _goToHome();
            },
            onSkip: () {
              _goToHome();
            },
            showSkipButton: true,
            skip: NewButton(
                text: translate('skip'),
                textStyle: AppStyle.titleStyle.copyWith(
                    color: AppColorsController().white,
                    fontWeight: AppFontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                textPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onPressed: null),
            skipStyle: TextButton.styleFrom(
              foregroundColor: AppColorsController().white,
            ),
            nextStyle: TextButton.styleFrom(
              foregroundColor: AppColorsController().white,
            ),
            next: NewButton(
                text: translate('next'),
                textStyle: AppStyle.titleStyle.copyWith(
                    color: AppColorsController().white,
                    fontWeight: AppFontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                textPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onPressed: null),
            done: NewButton(
                text: translate('next'),
                textStyle: AppStyle.titleStyle.copyWith(
                    color: AppColorsController().white,
                    fontWeight: AppFontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                textPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onPressed: null),
            doneStyle: TextButton.styleFrom(
              foregroundColor: AppColorsController().white,
            ),
            dotsDecorator: DotsDecorator(
                size: const Size.square(12.0),
                activeSize: const Size(24.0, 12.0),
                activeColor: AppColorsController().darkRed,
                color: Colors.black54,
                spacing: const EdgeInsets.symmetric(horizontal: 8.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
          )
        ],
      ),
    );
  }

  Widget _titleWidget(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Text(
        "$text",
        style: AppStyle.bigTitleStyle2.copyWith(
            color: AppColorsController().borderColor,
            fontWeight: AppFontWeight.bold,
            height: 1.8,
            overflow: TextOverflow.ellipsis),
        textAlign: TextAlign.start,
        maxLines: 10,
      ),
    );
  }

  void _goToHome() {
    DIManager.findDep<SharedPrefs>().setIsFirst(false);
    DIManager.findNavigator().pushNamedAndRemoveUntil(
      HomePage.routeName,
    );
  }
}
