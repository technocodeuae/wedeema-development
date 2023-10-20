import 'package:flutter/material.dart';
import 'package:wadeema/core/shared_prefs/shared_prefs.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/sign_in_page.dart';
import '../../../../core/di/di_manager.dart';
import 'package:get/get.dart';
import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_consts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui/work_focus_version/general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../ui/work_focus_version/root/pages/root_page.dart';

class AppUtils {
  static dynamic ifNullElse<TYPE1, TYPE2>(
      {required TYPE1 toTestNull,
      required TYPE2 toReturnIfNull,
      required TYPE2 toReturnIfNotNull}) {
    if (toTestNull == null) return toReturnIfNull;
    return toReturnIfNotNull;
  }

  static void jumpToTab(PagesEnum page) {
    DIManager.findDep<TabController>().index = page.index;
  }

  static Size textSize({required String text, required TextStyle style}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }


  static String convertColorTHex(Color color) {
    return color.value.toRadixString(16);
  }

  static localize({whenArabic, whenEnglish}) {
    switch (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode) {
      case AppConsts.LANG_EN:
        return whenEnglish;
      case AppConsts.LANG_AR:
        return whenArabic;
    }
    return whenEnglish;
  }


  static void launchURL(String _url) async {
    try {
      await launch(_url);
    } catch (e) {
      print('I Can nooooooooooooooooooot launch this link : $_url | $e');

    }
  }

  static String numberLimiter(int num) {
    if (num == 0) {
      return '';
    } else if (num > 0 && num < 100) {
      return '$num';
    } else {
      return '99+';
    }
  }

  static showMessage({required BuildContext context, required String message}) {
    var snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool checkIfGuest(BuildContext context){
    if(DIManager.findDep<SharedPrefs>()
        .getToken()?.isEmpty ?? true){
      var snackBar = SnackBar(
        content:
        Text(translate('you_should_sign_in')),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);

      DIManager.findNavigator().pushNamed(
        SignInPage.routeName,
      );

      return true;
    }
    return false;
  }

  static bool isFist() {
    return DIManager.findDep<SharedPrefs>().getIsFirst() ?? true;
  }
}
