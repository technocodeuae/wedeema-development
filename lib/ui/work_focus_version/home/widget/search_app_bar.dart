import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/app_general_utils.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/icons/account_icon.dart';
import '../../general/icons/notification_icon.dart';
import '../../general/icons/search_icon.dart';
import '../../notifications/pages/notifications_page.dart';
import '../../profile/pages/my_account_page.dart';
import '../pages/search_page.dart';

class SearchAppBarWidget extends StatelessWidget {
  TextEditingController controller;

  SearchAppBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    //  height: 195.sp,
      decoration: ThemeProvider().appMode == "light"
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.appBarBackgroundImage),
                  fit: BoxFit.fill),
            )
          : BoxDecoration(color: AppColorsController().white),
      child: Padding(
        padding: EdgeInsets.all( 32.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppAssets.logoImage,
              height: 40.sp,
              width: 72.sp,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    DIManager.findNavigator().pushNamed(
                      SearchPage.routeName,
                    );
                  },
                  child: SearchIcon(
                    height: 26.sp,
                    width: 26.sp,
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                InkWell(
                  onTap: () {
                    if (!AppUtils.checkIfGuest(context)) {
                      DIManager.findNavigator().pushNamed(
                        NotificationsPage.routeName,
                      );
                    }
                  },
                  child: NotificationIcon(
                    width: 31.sp,
                    height: 26.sp,
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),

                InkWell(
                  onTap: () {
                    if (!AppUtils.checkIfGuest(context)) {
                      DIManager.findNavigator().pushNamed(
                        MyAccountPage.routeName,
                      );
                    }
                  },
                  child: (DIManager.findDep<SharedPrefs>().getImageProfile() !=
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
                      : AccountIcon(
                          width: 32.sp,
                          height: 32.sp,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//
// Container(
// width: 286.sp,
// height: 50.sp,
// padding: EdgeInsets.symmetric(horizontal: 16.sp),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(
// Radius.circular(20.sp),
// ),
// border: Border.all(
// color: AppColorsController().borderColor, width: 0.2),
// color: Color.fromRGBO(255, 255, 255, 0.1),
// ),
// child: Row(
// children: [
// InkWell(
// onTap: () {
// if (DIManager.findDep<SharedPrefs>().getToken() !=
// null &&
// DIManager.findDep<SharedPrefs>()
//     .getToken()!
//     .isNotEmpty) {
// } else {
// var snackBar = SnackBar(
// content: Text(translate('you_should_sign_in')),
// behavior: SnackBarBehavior.floating,
// duration: Duration(seconds: 1),
// );
// ScaffoldMessenger.of(context)
//     .showSnackBar(snackBar);
// }
// },
// child: SearchIcon(
// height: 26.sp,
// width: 26.sp,
// ),
// ),
// SizedBox(
// width: 8.sp,
// ),
// Text(
// translate("search"),
// style: AppStyle.verySmallTitleStyle.copyWith(
// color: AppColorsController().greyTextColor,
// fontWeight: AppFontWeight.regular),
// )
// ],
// ),
// )