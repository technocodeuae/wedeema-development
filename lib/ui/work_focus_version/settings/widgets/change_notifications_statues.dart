import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/notifications/notifications_bloc.dart';
import '../../../../blocs/notifications/states/notifications_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';

class ChangeNotificationsStatues extends StatefulWidget {
  const ChangeNotificationsStatues();

  @override
  _ChangeNotificationsStatuesState createState() =>
      _ChangeNotificationsStatuesState();
}

class _ChangeNotificationsStatuesState
    extends State<ChangeNotificationsStatues> {
  bool _value = false;
  final settingsBloc = DIManager.findDep<NotificationsCubit>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _value = DIManager.findDep<SharedPrefs>().notificationStatus.val == "on"
        ? true
        : false;

    print("_value" +
        DIManager.findDep<SharedPrefs>().notificationStatus.val.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      bloc: settingsBloc,
      listener: (_, state) {
        final settingsState = state.changeNotificationState;

        if (settingsState is BaseFailState) {}

        if (_isLoading && (settingsState is ChangeNotificationSuccessState)) {
          _isLoading = false;
          print("HIIIIIIII");
          if (_value == true) {
            DIManager.findDep<SharedPrefs>()..setNotificationsStatus("off");
          } else {
            DIManager.findDep<SharedPrefs>()..setNotificationsStatus("on");
                }

          setState(() {
            _value = !_value;

          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColorsController().containerPrimaryColor,
          border: Border.all(
            width: 0.2,
            // assign the color to the border color
            color: AppColorsController().borderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.containerBorderRadius),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        margin: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (!AppUtils.checkIfGuest(context)) {
                  setState(() {
                    settingsBloc
                        .changeNotificationStatus((_value == true) ? 0 : 1);
                    _isLoading = true;
                  });
                }
              },
              child: Container(
                width: 60.0.sp,
                height: 35.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: _value ==true ? Colors.green[400] : Colors.red[400],
                ),
                child: Align(
                  alignment: _value == true
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: 22.0.sp,
                      height: 22.0.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColorsController().white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12.sp,
            ),
            Container(
              child: Text(
                translate("change_notifications_statues"),
                style: AppStyle.smallTitleTextStyle.copyWith(
                  color: AppColorsController().textPrimaryColor,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
