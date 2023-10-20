import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/facebook_icon.dart';
import '../../general/icons/google_icon.dart';
import '../../general/icons/phone_icon.dart';
import '../pages/sign_in_with_phone_number.dart';
class SocialMediaLogin extends StatefulWidget {
  const SocialMediaLogin({Key? key}) : super(key: key);

  @override
  State<SocialMediaLogin> createState() => _SocialMediaLoginState();
}

class _SocialMediaLoginState extends State<SocialMediaLogin> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
          child: AppButton(
            childPadding: EdgeInsets.symmetric(horizontal: 48.sp),
            onPressed: () {
              DIManager.findNavigator().pushNamed(
                SignInWithPhoneNumber.routeName,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PhoneIcon(
                  width: 26.sp,
                ),
                SizedBox(width: 28.sp,),
                Text(
                  translate("sign_in_with_phone"),
                  style: AppStyle.verySmallTitleStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: AppFontWeight.midLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
          child: AppButton(
            childPadding: EdgeInsets.symmetric(horizontal: 48.sp),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FaceBookIcon(
                  width: 26.sp,
                ),
                SizedBox(width: 28.sp,),

                Text(
                  translate("login_with_facebook"),
                  style: AppStyle.verySmallTitleStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: AppFontWeight.midLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
          child: AppButton(
            childPadding: EdgeInsets.symmetric(horizontal: 48.sp),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GoogleIcon(
                  width: 26.sp,
                ),
                SizedBox(width: 28.sp,),
                Text(
                  translate("login_with_google"),
                  style: AppStyle.verySmallTitleStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: AppFontWeight.midLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40.sp,
        ),
      ],
    );
  }
}
