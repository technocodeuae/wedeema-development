import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/lock_icon.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/phone_icon.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/email_icon.dart';
import '../../general/text_fields/text_field_decorator.dart';
import '../../general/text_fields/text_field_widget.dart';
import 'otp_page.dart';
class SignInWithPhoneNumber extends StatefulWidget {
  static const routeName = '/SignInWithPhoneNumber';

  const SignInWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {

  TextEditingController phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarWidget(
              name: translate(""),
              child: InkWell(
                onTap: (){
                  DIManager.findNavigator().pop();

                },
                child: BackIcon(
                  width: 26.sp,
                  height: 18.sp,
                ),
              ),
            ),
            SizedBox(
              height: 78.sp,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.sp,),
              child: Text(
                translate("sign_in")+" "+translate("with")+" "+translate("phone_number"),
                style: AppStyle.smallTitleStyle.copyWith(
                  color: AppColorsController().naveTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp),
              child: TextFieldDecorator(
                height: 55.sp,
                child: TextFieldWidget(
                  controller: phoneNumberController,
                  hint: translate("phone_number"),
                  icon: PhoneIcon(
                    width: 32.sp,
                  ),
                ),
              ),
            ),
            AppButton(
              width: 262.sp,
              height: 55.sp,
              childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
              onPressed: () {
                showDialog(
                    context: context,

                    builder: (BuildContext context) {


                  return AlertDialog(

                      backgroundColor: AppColorsController().containerPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            Dimens.containerBorderRadius,
                          ),
                        ),

                      ),
                      content: OTPPage());
                }
                );
              },
              child: Text(
                translate("send_otp"),
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().textPrimaryColor,
                  fontWeight: AppFontWeight.midLight,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
