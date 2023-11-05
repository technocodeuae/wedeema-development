import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/forget_pasword_page.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/sign_up_page.dart';
import 'package:wadeema/ui/work_focus_version/general/app_bar/app_bar.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/home_page.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/check_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/text_field_widget.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/SignInPage';
  final int? type ;

  const SignInPage({Key? key, this.type }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodePhone = FocusNode();

  String passwordValue = "";
  String phoneValue = "";

  final _authBloc = DIManager.findDep<AuthCubit>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _hidePassword = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: BackLongPress(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Stack(
              children: [

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 35.h,),
                      AppBarWidget(
                        flip: true,
                        child:     widget.type == 0 ? InkWell(
                          onTap: () {
                            DIManager.findNavigator().pop();
                            // if (_isFilter()) {
                            //   DIManager.findNavigator().pop();
                            // } else {
                            //   if (!AppUtils.checkIfGuest(context)) {
                            //     DIManager.findNavigator().pushReplacementNamed(
                            //         SelectListingPage.routeName,
                            //         arguments: {'city_id': -1});
                            //   }
                            // }
                          },
                          child: BackIcon(
                            width: 80.sp,
                            height: 90.sp,
                          ),
                        ):Container(),
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
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _titleWidget(),
                                  SizedBox(height: 24,),
                                  _numberField(),
                                  SizedBox(height: 24,),
                                  _passwordField(),
                                  _forgotPasswordWidget(),
                                  _buildButton(),
                                  _registerWidget(),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Positioned(
                  top: 60.sp,
                  left: 131.sp,
                  right: 131.sp,
                  child: Image.asset(
                    AppAssets.logoImage,
                    height: 72.sp,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate('sign_in'),
            style: AppStyle.bigTitleStyle
                .copyWith(color: AppColorsController().black, fontSize: 20.sp, fontWeight: AppFontWeight.bold),
          ),
          Text(
            translate('welcomeToWadeema'),
            style:
                AppStyle.bigTitleStyle.copyWith(color: AppColorsController().black, fontWeight: AppFontWeight.semiBold),
          )
        ],
      ),
    );
  }

  Widget _numberField() {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          height: 50.sp,
          margin: EdgeInsets.symmetric(horizontal: 12.sp),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColorsController().borderColor,
              width: 0.1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.containerBorderRadius),
            ),
            color: AppColorsController().containerPrimaryColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.sp,
            ),
            child: Center(child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Text(AppConsts.countryCodeWithEmoji,style: AppStyle.smallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.bold),),
            )),
          ),
        ),
        Expanded(
          child: Container(
            height: 50.sp,
            alignment: Alignment.center,
            margin: EdgeInsetsDirectional.only(start: 6.sp,),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColorsController().borderColor,
                width: 0.1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.containerBorderRadius),
              ),
              color: AppColorsController().containerPrimaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.sp,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.sp),
                  child: TextFieldWidget(
                    controller: phoneController,
                    focusNode: focusNodePhone,
                    nextFocusNode: focusNodePassword,
                    hint: translate('phone_number'),
                    maxLength: AppConsts.numberMaxLength,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    onTextChanged: (value) {
                      setState(() {
                        phoneValue = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.sp,)
      ],
    );
  }

  Widget _passwordField() {
    return Container(
      height: 50.sp,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColorsController().borderColor,
          width: 0.1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.containerBorderRadius),
        ),
        color: AppColorsController().containerPrimaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 4.sp),
          child: TextFieldWidget(
            controller: passwordController,
            focusNode: focusNodePassword,
            hint: translate('password'),
            obscureText: _hidePassword,
            maxLength: AppConsts.passwordMaxLength,
            isRequired: true,
            keyboardType: TextInputType.text,
            suffix: InkWell(
                onTap: () {
                  _hidePassword = !_hidePassword;
                  setState(() {});
                },
                child: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColorsController().darkRed,
                )),
            onTextChanged: (value) {
              setState(() {
                passwordValue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordWidget(){
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: TextButton(
          onPressed: (){
            DIManager.findNavigator().pushNamed(
              ForgetPage.routeName,
            );
          },
          style: TextButton.styleFrom(foregroundColor: AppColorsController().primaryColor),
          child: Text(
            translate("forgot_password"),
            style: AppStyle.verySmallTitleStyle.copyWith(
              color: AppColorsController().black,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: TextButton(
          onPressed: () {
            DIManager.findNavigator().pushNamed(SignUpPage.routeName);
          },
          style: TextButton.styleFrom(foregroundColor: AppColorsController().primaryColor),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            translate('do_not_have_account'),
            style: AppStyle.smallTitleStyle.copyWith(
              color: AppColorsController().black,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          SizedBox(width: 4,),
          Text(
            translate('register_now'),
            style: AppStyle.smallTitleStyle.copyWith(
              color: AppColorsController().darkRed,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ]),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 24.sp,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
            child: NewButton(
              isLoading: _isLoading,
                text: translate('sign_in'),
                textStyle: AppStyle.titleStyle.copyWith(
                    color: AppColorsController().white, fontWeight: AppFontWeight.bold, overflow: TextOverflow.ellipsis),
                textPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                onPressed: () {
                  _signIn();
                }),
          ),
        ),
        NewButton(


            text: translate('sign_in_as_guest'),
            textStyle: AppStyle.titleStyle.copyWith(
                color: AppColorsController().white, fontWeight: AppFontWeight.bold, overflow: TextOverflow.ellipsis),
            textPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 4),
            onPressed: () {
              DIManager.findNavigator().pushNamedAndRemoveUntil(
                HomePage.routeName,
              );
            }),
      ],
    );
  }

  void _signIn(){
    _formKey.currentState!.save();

    if (phoneValue.isEmpty || passwordValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(translate("please_fill_all_requirement_data")),
      ));
    } else {
      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });

      if(phoneValue.startsWith('0',)) phoneValue = phoneValue.substring(1,phoneValue.length);

      _authBloc.login(
        password: passwordValue,
        email: '${AppConsts.countryCode}${phoneValue}',
        // email: 'ali@etechnocode.com',
      );
    }
  }
}
