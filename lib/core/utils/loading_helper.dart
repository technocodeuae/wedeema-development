import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class LoadingHelper {

   static void showLoadingDialog() {
     EasyLoading.instance
     ..loadingStyle = EasyLoadingStyle.light;
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
        indicator: SizedBox(
          width: 100,
          height: 100,
          child: SpinKitFoldingCube(
            size: 40.0,
            color: DIManager.findDep<AppColorsController>().primaryColor,
          ),
        ),
    );
  }

   static showLoadingView({Color? color}) {
    return Center(
      child: SpinKitFoldingCube(
        color: color ?? DIManager.findDep<AppColorsController>()
            .primaryColor,
        size: 40.0,
      ),
    );
  }

   static showCatLoadingView({Color? color}) {
    return Center(
      child: SpinKitRipple(
        color: color ?? DIManager.findDep<AppColorsController>()
            .primaryColor,
        size: 40.0,
      ),
    );
  }

   static void dismissDialog(){
    EasyLoading.dismiss();
  }

}
