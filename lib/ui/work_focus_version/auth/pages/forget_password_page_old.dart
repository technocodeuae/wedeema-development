import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/sign_in_page.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/email_icon.dart';
import '../../general/icons/lock_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/text_field_decorator.dart';
import '../../general/text_fields/text_field_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = '/ForgetPasswordPageOld';

  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailController = TextEditingController();
  String emailValue = "";

  bool  _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: SafeArea(
          child: BackLongPress(

            child: LoadingColumnOverlay(
            isLoading: _isLoading,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBarWidget(
                    name: translate(""),
                    child: InkWell(
                      onTap: () {
                        DIManager.findNavigator().pop();
                      },
                      child: BackIcon(
                        width: 26.sp,
                        height: 18.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),

                      child: ListView(
                        children: [
                          SizedBox(
                            height: 78.sp,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal:60.0),
                            child: Column(
                              children: [
                                LockIcon(
                                  width: 40.sp,
                                  height: 100.sp,
                                ),
                                SizedBox(
                                  height: 16.sp,
                                ),
                                Text(
                                  translate("forgot_password"),
                                  style: AppStyle.smallTitleStyle.copyWith(
                                    color: AppColorsController().naveTextColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.sp,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.sp,
                            ),
                            child: Text(
                              translate("send_you_password_reset"),
                              style: AppStyle.verySmallTitleStyle.copyWith(
                                color: AppColorsController().naveTextColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          BlocConsumer<AuthCubit, AuthState>(
                              bloc: DIManager.findDep<AuthCubit>(),
                              listener: (_, state) {

                                final forgetPasswordState = state.forgetPassword;
                                if (_isLoading == true &&forgetPasswordState is BaseFailState) {
                                  CustomSnackbar.showErrorSnackbar(
                                    forgetPasswordState.error!,
                                  );

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                                if (_isLoading == true && forgetPasswordState
                                    is ForgetPasswordSuccessState) {

                                  setState(() {
                                    _isLoading = false;
                                  });
                                  final snackBar = SnackBar(
                                    content: Text(
                                        translate('send_password')),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  DIManager.findNavigator().pushNamedAndRemoveUntil(
                                    SignInPage.routeName,
                                  );
                                }
                              },
                              builder: (_, state) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.sp, vertical: 24.sp),
                                  child: TextFieldDecorator(
                                    height: 55.sp,
                                    child: TextFieldWidget(
                                      controller: emailController,
                                      hint: translate("email"),
                                      icon: EmailIcon(
                                        width: 31.sp,
                                        height: 22.sp,
                                      ),
                                      onTextChanged: (value) {
                                        setState(() {
                                          emailValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal:80.0.sp),
                            child: AppButton(
                              width: 262.sp,
                              height: 55.sp,
                              childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                DIManager.findDep<AuthCubit>()
                                    .forgetPassword(emailValue);
                              },
                              child: Text(
                                translate("reset_password"),
                                style: AppStyle.verySmallTitleStyle.copyWith(
                                  color: AppColorsController().textPrimaryColor,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
