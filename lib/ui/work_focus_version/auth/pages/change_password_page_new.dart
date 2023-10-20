import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/sign_in_page.dart';
import 'package:wadeema/ui/work_focus_version/general/app_bar/app_bar.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/back_icon.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/home_page.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/text_field_widget.dart';

class ChangePasswordPageNew extends StatefulWidget {
  static const routeName = '/ChangePasswordPageNew';

  final String phoneNumber;

  const ChangePasswordPageNew({Key? key,required this.phoneNumber}) : super(key: key);

  @override
  State<ChangePasswordPageNew> createState() => _ChangePasswordPageNewState();
}

class _ChangePasswordPageNewState extends State<ChangePasswordPageNew> {
  final TextEditingController passwordController = TextEditingController();
  String passwordValue = "";


  final _authBloc = DIManager.findDep<AuthCubit>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;



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
          child: LoadingColumnOverlay(
            isLoading: _isLoading,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBarWidget(
                      flip: true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
                                _passwordField(),
                                SizedBox(height: 24,),
                                _buildButton()
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
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
            translate('change_password'),
            style: AppStyle.bigTitleStyle
                .copyWith(color: AppColorsController().black, fontSize: 20.sp, fontWeight: AppFontWeight.bold),
          )
        ],
      ),
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
            hint: translate('password'),
            obscureText: true,
            maxLength: AppConsts.passwordMaxLength,
            isRequired: true,
            keyboardType: TextInputType.text,
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


  _buildButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 24.sp,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
        child: NewButton(
            text: translate('change_password'),
            textStyle: AppStyle.titleStyle.copyWith(
                color: AppColorsController().white, fontWeight: AppFontWeight.bold, overflow: TextOverflow.ellipsis),
            textPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
            onPressed: () {
              _sendData();
            }),
      ),
    );
  }

  void _sendData(){
    _formKey.currentState!.save();

    if (passwordValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(translate("please_fill_all_requirement_data")),
      ));
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });


    setState(() {
      _isLoading = true;
    });

    _authBloc.changePassword(passwordValue,mobile: widget.phoneNumber.replaceAll('+', ''),onDone: (){
      setState(() {
        _isLoading = false;
      });
      DIManager.findNavigator().pushNamedAndRemoveUntil(
        SignInPage.routeName,
      );
    }, onError: () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
