import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class DarkMode extends StatefulWidget {
  const DarkMode();

  @override
  _DarkModeState createState() =>
      _DarkModeState();
}

class _DarkModeState
    extends State<DarkMode> {
  bool _value = false;
  final settingsBloc = DIManager.findDep<NotificationsCubit>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _value = DIManager.findDep<SharedPrefs>().appMode.val == "dark"
        ? true
        : false;

    print("_value" +
        DIManager.findDep<SharedPrefs>().appMode.val.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

              if(_value == true)
                ThemeProvider()
                    .refreshDarkLightModeColor("light");
              else
                ThemeProvider()
                    .refreshDarkLightModeColor("dark");
              setState(() {


                _value = DIManager.findDep<SharedPrefs>().appMode.val == "dark"
                    ? true
                    : false;
              });
            },
            child: Container(
              width: 60.0.sp,
              height: 35.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _value ==true ? Colors.white : Colors.grey,
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
              translate("dark_mode"),
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
    );
  }
}
