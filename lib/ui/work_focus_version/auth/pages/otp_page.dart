import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';

import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class OTPPage extends StatefulWidget {
  static const routeName = '/OTPPage';

  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  String? _otp;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout({int? milliseconds}) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305.sp,
      width: 360.sp,
      // decoration: BoxDecoration(
      //   color: AppColorsController().containerPrimaryColor,
      //   border:
      //       Border.all(color: AppColorsController().borderColor, width: 0.2),
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(
      //       Dimens.containerBorderRadius,
      //     ),
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            translate("verification_code"),
            style: AppStyle.smallTitleStyle.copyWith(
              color: AppColorsController().naveTextColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.sp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: AppColorsController().greyIconColor,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Text(
                  timerText,
                  style: AppStyle.verySmallTitleStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: AppFontWeight.midLight,
                  ),
                )
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColorsController().greyBackground,
              border: Border.all(
                width: 0.2,
                color: AppColorsController().black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.containerBorderRadius),),
            ),
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpInput(_fieldOne, true), // auto focus
                OtpInput(_fieldTwo, false),
                OtpInput(_fieldThree, false),
                OtpInput(_fieldFour, false)
              ],
            ),
          ),

        ],
      ),
    );
  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.sp,
      width: 50.sp,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        // decoration: const InputDecoration(
        //     border: OutlineInputBorder(),
        //     counterText: '',
        //     hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
