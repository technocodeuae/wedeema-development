import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/sign_up_page.dart';
import 'package:wadeema/ui/work_focus_version/general/app_bar/app_bar.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/enter_icon.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/home_page.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/check_icon.dart';
import '../../general/icons/email_icon.dart';
import '../../general/icons/lock_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/text_field_decorator.dart';
import '../../general/text_fields/text_field_widget.dart';
import '../widget/social_media_login.dart';
import 'forget_password_page_old.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/SignInPageNew';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController passwordController = TextEditingController();
  final FocusNode focusNodePassword = FocusNode();
  String passwordValue = "";
  TextEditingController emailController = TextEditingController();
  final FocusNode focusNodeEmail = FocusNode();

  String emailValue = "";

  final _authBloc = DIManager.findDep<AuthCubit>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;



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
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppBarWidget(
                            name: translate("login"),
                            child: EnterIcon(
                              width: 26.sp,
                            ),
                          ),
                          SizedBox(
                            height: 50.sp,
                          ),
                          BlocConsumer<AuthCubit, AuthState>(
                              bloc: _authBloc,
                              listener: (_, state) {

                                final loginState = state.loginState;
                                if (_isLoading == true &&loginState is BaseFailState) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  CustomSnackbar.showErrorSnackbar(
                                    loginState.error!,
                                  );
                                }
                                if (_isLoading == true &&loginState is LoginSuccessState) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  DIManager.findNavigator().pushNamedAndRemoveUntil(
                                    HomePage.routeName,
                                  );
                                }
                              },
                              builder: (_, state) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.sp, vertical: 10.sp),
                                      child: TextFieldDecorator(
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
                                          isRequired: true,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.sp, vertical: 10.sp),
                                      child: TextFieldDecorator(
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
                                          isRequired: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.sp,
                                    ),
                                  ],
                                );
                              }),
                          _buildButton(),
                          Row(
                            children: [
                              SizedBox(
                                height: 1.5.sp,
                                width: 190.sp,
                                child: Container(
                                  color: AppColorsController().black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.sp,
                                ),
                                child: Text(
                                  translate("or"),
                                  style: AppStyle.verySmallTitleStyle.copyWith(
                                    color: AppColorsController().black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.sp,
                                width: 190.sp,
                                child: Container(
                                  color: AppColorsController().black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 26.sp,
                          ),
                          _buildAgreementPrivacyAndPolicy(),
                          SocialMediaLogin(),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 70.sp,
                      left: 131.sp,
                      right: 131.sp,
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          AppAssets.logoImage,
                          height: 72.sp,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAgreementPrivacyAndPolicy() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
      child: AppButton(
        width: 342.sp,
        height: 44.sp,
        childPadding: EdgeInsets.symmetric(horizontal: 10.sp),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CheckIcon(
              width: 22.sp,
            ),
            SizedBox(
              width: 8.sp,
            ),
            Text(
              translate("agreement_privacy"),
              style: AppStyle.verySmallTitleStyle.copyWith(
                color: AppColorsController().textPrimaryColor,
                fontWeight: AppFontWeight.midLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildButton() {
    return Column(
      children: [
        AppButton(
          width: 150.sp,
          height: 44.sp,
          childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
          onPressed: () {
            _formKey.currentState!.save();

            if (emailValue.isEmpty || passwordValue.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(translate("please_fill_all_requirement_data")),
              ));
            } else {
              setState(() {
                _isLoading = true;
              });
              _authBloc.login(
                password: passwordValue,
                email: emailValue,
              );
            }
          },
          child: Text(
            translate("sign_in"),
            style: AppStyle.verySmallTitleStyle.copyWith(
              color: AppColorsController().textPrimaryColor,
              fontWeight: AppFontWeight.midLight,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                width: 160.sp,
                height: 44.sp,
                childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
                onPressed: () {
                  DIManager.findNavigator().pushNamed(
                    ForgetPasswordPage.routeName,
                  );
                },
                child: Text(
                  translate("forgot_password"),
                  style: AppStyle.verySmallTitleStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: AppFontWeight.midLight,
                  ),
                ),
              ),
              SizedBox(
                width: 42.sp,
              ),
              AppButton(
                width: 160.sp,
                height: 44.sp,
                childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
                onPressed: () {
                  DIManager.findNavigator().pushNamed(SignUpPage.routeName);
                },
                child: Text(
                  translate("new_here"),
                  style: AppStyle.verySmallTitleStyle.copyWith(
                    color: AppColorsController().textPrimaryColor,
                    fontWeight: AppFontWeight.midLight,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppButton(
          width: 150.sp,
          height: 44.sp,
          childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
          onPressed: () {
            DIManager.findNavigator().pushNamedAndRemoveUntil(
              HomePage.routeName,
            );
          },
          child: Text(
            translate("sign_in_as_guest"),
            style: AppStyle.verySmallTitleStyle.copyWith(
              color: AppColorsController().textPrimaryColor,
              fontWeight: AppFontWeight.midLight,
            ),
          ),
        ),
        SizedBox(
          height: 36.sp,
        ),
      ],
    );
  }
}
