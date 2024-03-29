import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/bloc/states/base_init_state.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/send_otp_page.dart';
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
import '../../home/widget/app_bar_app.dart';

class ForgetPage extends StatefulWidget {
  static const routeName = '/ForgetPasswordPage';

  const ForgetPage({Key? key}) : super(key: key);

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final TextEditingController phoneController = TextEditingController();


  String phoneValue = "";

  final _authBloc = DIManager.findDep<AuthCubit>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarApp(context,text: '',
      isNeedBack: true,
      isAuth: true,
      ),
      backgroundColor: AppColorsController().white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: BackLongPress(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 15.sp,),
                  // AppBarWidget(
                  //   flip: true,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 8.0),
                  //     child: InkWell(
                  //       onTap: () {
                  //         DIManager.findNavigator().pop();
                  //       },
                  //       child: BackIcon(
                  //         width: 26.sp,
                  //         height: 18.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  BlocConsumer<AuthCubit, AuthState>(
                      bloc: _authBloc,
                      listener: (_, state) {
                        print("State==============> ${state.loginState}");
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
                    hint: translate('phone_number'),
                    maxLength: AppConsts.numberMaxLength,
                    isRequired: true,
                    autoFocus: true,
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
        SizedBox(width: 6.sp,),
      ],
    );
  }


  _buildButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 24.sp,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
        child: NewButton(isLoading: _isLoading,
            text: translate('send_verification'),
            textStyle: AppStyle.titleStyle.copyWith(
                color: AppColorsController().white, fontWeight: AppFontWeight.bold, overflow: TextOverflow.ellipsis),
            textPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
            onPressed: () {
              _sendVerification();
            }),
      ),
    );
  }

  void _sendVerification(){
    _formKey.currentState!.save();

    if (phoneValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(translate("please_fill_all_requirement_data")),
      ));
      return;
    }

      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });

      if(phoneValue.startsWith('0',)) phoneValue = phoneValue.substring(1,phoneValue.length);

    setState(() {
      _isLoading = true;
    });
    _authBloc.sendVerificationCode(AppConsts.countryCode, '$phoneValue',
        isChangePassword: true,
        onDone: (){
      setState(() {
        print("SENDOTPPAGE===================================>");
        _isLoading = false;
      });

      DIManager.findNavigator().pushNamed(
          SendOtpPage.routeName,
          arguments: {'phone_number': '+${AppConsts.countryCode}$phoneValue', 'is_change_password': true});
    },onError: (){
      print("Errrrorororor");
      setState(() {
        _isLoading = false;
    });
    });
  }
}
