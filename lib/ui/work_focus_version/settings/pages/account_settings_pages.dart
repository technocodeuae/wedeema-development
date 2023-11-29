import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/app_bar_app.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../auth/pages/change_password_page.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/icons/back_icon.dart';
import '../../profile/widget/item_profile_card_widget.dart';
import '../widgets/change_notifications_statues.dart';
import '../widgets/dark_mode.dart';

class AccountSettingsPage extends StatelessWidget {
  static const routeName = '/AccountSettingsPage';

  const AccountSettingsPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarApp(context, text: translate("account_settings"),
      isNeedBack: true),
      body: SafeArea(
        child: Column(
          children: [
            // AppBarWidget(
            //   name: translate("account_settings"),
            //   child: InkWell(
            //     onTap: () {
            //       DIManager.findNavigator().pop();
            //     },
            //     child: BackIcon(
            //       width: 26.sp,
            //       height: 18.sp,
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    (DIManager.findDep<SharedPrefs>().getToken() == null ||
                        DIManager.findDep<SharedPrefs>()
                            .getToken()!
                            .isEmpty)?Container():  ItemProfileCardWidget(
                        title: translate("change_password"),
                        icon: AppAssets.changePasswordIcon,
                        onPressed: () {
                          if (!AppUtils.checkIfGuest(context)) {
                            DIManager.findNavigator().pushNamed(
                              ChangePasswordPage.routeName,
                            );
                          }
                        }),

                    ChangeNotificationsStatues(
                    ),
                    DarkMode(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


