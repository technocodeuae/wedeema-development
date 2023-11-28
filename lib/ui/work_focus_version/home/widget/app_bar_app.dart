import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/app_general_utils.dart';
import '../../general/icons/account_icon.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/notification_icon.dart';
import '../../general/icons/search_icon.dart';
import '../../notifications/pages/notifications_page.dart';
import '../../profile/pages/my_account_page.dart';
import '../pages/search_page.dart';



PreferredSizeWidget appBarApp(context,
{
  required String text,
}
    ){

  return PreferredSize(
      preferredSize: Size.fromHeight(100),
    child: AppBar(

    backgroundColor: AppColorsController().white,
    flexibleSpace: Container(

      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppAssets.appBarBackgroundImage),
            fit: BoxFit.fill),
      ),
    ),
    // centerTitle: true,
    elevation: 0,
    title: Padding(
      padding: EdgeInsets.only(top: 25),
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
                  width: 33.sp,
                  height: 33.sp,
                  child: Stack(
                    children: [
                      AccountIcon(
                        width: 30.sp,
                        height: 30.sp,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          AppConsts.IMAGE_URL +
                              DIManager.findDep<SharedPrefs>()
                                  .getImageProfile()
                                  .toString(),

                        ),
                        backgroundColor: Colors.transparent,

                      ),
                    ],
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
centerTitle: true,
//     leading: Transform.scale(
//       scale: 0.5,
//       child: InkWell(
//         onTap: () {
//           // print(data[0]);
//           // setState(() {
//           //   isLoading = false;
//           //   data.clear();
//           // });
//           DIManager.findNavigator().pop();
//           // debugPrint(DIManager.findDep<SharedPrefs>().getToken());
// // print(DIManager.findDep<SharedPrefs>().getToken());
//         },
//         child: BackIcon(
//           width: 26.sp,
//           height: 18.sp,
//         ),
//       ),
//     ),
//     iconTheme: IconThemeData(
//       size: 20.sp, // تحديد حجم الأيقونة في الـ leading
//     ),
  ), );

}