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
import '../../home/widget/app_bar_app.dart';
import '../../profile/pages/my_profile_page.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName = '/ChangePasswordPage';

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController emailController = TextEditingController();
  String emailValue = "";


  TextEditingController passwordController = TextEditingController();
  final FocusNode focusNodePassword = FocusNode();
  String passwordValue = "";

  bool  _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      appBar: appBarApp(context,text: translate("change_password"),
          isNeedBack: true
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: SafeArea(
          child: LoadingColumnOverlay(
            isLoading: _isLoading,
            child: BackLongPress(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // AppBarWidget(
                  //   name: translate("change_password"),
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
                                  translate("change_password"),
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

                          BlocConsumer<AuthCubit, AuthState>(
                              bloc: DIManager.findDep<AuthCubit>(),
                              listener: (_, state) {


                                final changePasswordState = state.changePassword;
                                if (_isLoading == true && changePasswordState is BaseFailState) {
                                  CustomSnackbar.showErrorSnackbar(
                                    changePasswordState.error!,
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                                if (_isLoading == true && changePasswordState is ChangePasswordSuccessState)  {

                                  setState(() {
                                    _isLoading = false;
                                  });
                                  const snackBar = SnackBar(
                                    content: Text('We change password success!'),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                  DIManager.findDep<AuthCubit>().logout();



                                }
                              },
                              builder: (_, state) {
                                return   Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp),
                                  child: Column(
                                    children: [
                                      TextFieldDecorator(

                                        child: TextFieldWidget(
                                          onTextChanged: (value) {
                                            setState(() {
                                              emailValue = value;
                                            });
                                          },
                                          controller: emailController,
                                          hint: translate("email"),
                                          icon: EmailIcon(
                                            width: 31.sp,
                                            height: 22.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.sp,),
                                      TextFieldDecorator(

                                        child: TextFieldWidget(

                                          onTextChanged: (value) {
                                            setState(() {
                                              passwordValue = value;
                                            });
                                          },
                                          controller: passwordController,
                                          hint: translate("password"),
                                          icon: LockIcon(
                                            width: 22.sp,
                                            height: 29.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.sp,),

                                    ],
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
                                DIManager.findDep<AuthCubit>().changePassword(passwordValue,email: emailValue);
                              },
                              child: Text(
                                translate("change_password"),
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
