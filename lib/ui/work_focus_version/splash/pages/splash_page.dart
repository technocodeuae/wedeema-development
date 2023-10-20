import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/tour/tour_page.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../home/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashPage';

  const SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final sharedPrefHelper = DIManager.findDep<SharedPrefs>();


  checkInternetConnection() {
    DIManager.findDep<ApplicationCubit>().onAppInit();
    DIManager.findDep<ApplicationCubit>().init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();


  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3), () {
      DIManager.findNavigator().pushNamedAndRemoveUntil(
        AppUtils.isFist()  ? TourPage.routeName : HomePage.routeName,
      );
    }
    );

    ScreenHelper(context);

    return Scaffold(
      // body: Container(
      //   child: SizedBox.expand(
      //
      //      child: FittedBox(
      //
      //        fit: BoxFit.fill,
      //        child: SizedBox(
      //          height: MediaQuery.of(context).size.height,
      //          width: MediaQuery.of(context).size.width,
      //
      //          child: VlcPlayer(
      //
      //            controller: _controller,
      //            aspectRatio: 9/16,
      //            placeholder:
      //            Container(
      //                decoration: BoxDecoration(
      //                  image: DecorationImage(image: AssetImage(AppAssets.splashBackgroundImage), fit: BoxFit.fill),
      //                ),
      //                child: Padding(
      //                  padding:  EdgeInsets.symmetric(horizontal: 56.sp),
      //                  child: Column(
      //                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                    children: [
      //                      SizedBox(height: 1,),
      //                      Center(
      //                        child: Image.asset( AppAssets.logoImage,
      //                            height: 155.sp,
      //                            fit: BoxFit.fill,
      //                        ),
      //                      ),
      //                    ],
      //                  ),
      //                ),
      //          ),
      //        ),
      //      ),
      //    ),
      //    ),
      // ),

      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: VlcPlayer(
      //     controller: _controller,
      //     aspectRatio:    MediaQuery.of(context).size.aspectRatio,
      //
      //     placeholder: Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage(AppAssets.splashBackgroundImage),
      //             fit: BoxFit.fill),
      //       ),
      //       child: Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 56.sp),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             SizedBox(
      //               height: 1,
      //             ),
      //             Center(
      //               child: Image.asset(
      //                 AppAssets.logoImage,
      //                 height: 155.sp,
      //                 fit: BoxFit.fill,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 56.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Hero(
              tag: 'logo',
              child: Image.asset(AppAssets.logoImage, height: 155.sp,
                fit: BoxFit.fill,),
            ),
            // Lottie.asset(AppAssets.logoAnimation,repeat: false,onLoaded: (s){
            //
            // },errorBuilder: (BuildContext context,
            //     Object error,
            //     StackTrace? stackTrace,){
            //   return Image.asset(AppAssets.logoImage, height: 155.sp,
            //     fit: BoxFit.fill,);
            // })
          ],
        ),
      ),
    );
  }
}
