import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wadeema/core/utils/date_utils/datetime_helper.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/change_password_page_new.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/complete_info_page.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/dialogs/custom_dialogs.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';

class SendOtpPage extends StatefulWidget {
  static const routeName = '/SendOtpPage';

  const SendOtpPage({Key? key, required this.phoneNumber, this.isChangePassword = false}) : super(key: key);

  final String phoneNumber;
  final bool isChangePassword;

  @override
  State<SendOtpPage> createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {
  final _authBloc = DIManager.findDep<AuthCubit>();

  final TextEditingController _controllerPinText = TextEditingController();

  bool _isLoading = false;
  bool _canResendCode = true;

  late DateTime eDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eDate = DateTime.now().toUtc().add(Duration(minutes: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: BackLongPress(
          child: LoadingColumnOverlay(
            isLoading: _isLoading,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleWidget(),
                        _editNumberWidget(),
                        SizedBox(
                          height: 32.sp,
                        ),
                        _codeField(),
                        _resendCodeWidget(),
                      ],
                    ),
                  )
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
            translate('verification_code'),
            style: AppStyle.bigTitleStyle
                .copyWith(color: AppColorsController().black, fontSize: 20.sp, fontWeight: AppFontWeight.bold),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Text(
            translate('enter_otp'),
            style: AppStyle.defaultStyle.copyWith(color: AppColorsController().black),
          )
        ],
      ),
    );
  }

  Widget _codeField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: PinCodeTextField(
            appContext: context,
            autoFocus: true,
            length: 4,
            animationType: AnimationType.fade,
            textStyle: AppStyle.bigTitleStyle.copyWith(color: AppColorsController().black, fontWeight: FontWeight.bold),
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 65,
                fieldWidth: 45,
                borderWidth: 0.6,
                selectedBorderWidth: 0.6,
                activeBorderWidth: 0.6,
                disabledColor: AppColorsController().black,
                activeColor: AppColorsController().black,
                errorBorderColor: AppColorsController().black,
                inactiveFillColor: AppColorsController().black,
                activeFillColor: AppColorsController().black,
                inactiveColor: AppColorsController().black,
                selectedColor: AppColorsController().black,
                selectedFillColor: AppColorsController().black),
            animationDuration: const Duration(milliseconds: 200),
            enableActiveFill: false,
            controller: _controllerPinText,
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              if (value.length >= 4) {
                setState(() => _isLoading = true);

                _authBloc.validateMobileNumber(value, widget.phoneNumber.replaceAll('+', ''),
                    isChangePassword: widget.isChangePassword, onDone: () {
                  setState(() => _isLoading = false);

                  CustomDialogs.showTowButtonsDialog(
                      context: context,
                      title: translate('verification_has_done'),
                      buttonText: translate('complete_registration'),
                      onPrssed: () {
                        Navigator.pop(context);
                        if (widget.isChangePassword) {
                          DIManager.findNavigator().pushReplacementNamed(ChangePasswordPageNew.routeName,
                              arguments: {'phone_number': widget.phoneNumber});
                        } else {
                          DIManager.findNavigator().pushReplacementNamed(CompleteInfoPage.routeName,
                              arguments: {'phone_number': widget.phoneNumber});
                        }
                      });
                }, onError: () {
                  setState(() => _isLoading = false);
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _editNumberWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(foregroundColor: AppColorsController().primaryColor),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            '${widget.phoneNumber.replaceAll('+', '')}',
            textDirection: TextDirection.ltr,
            style: AppStyle.defaultStyle.copyWith(
                color: AppColorsController().black, fontWeight: AppFontWeight.bold, fontSize: AppFontSize.fontSize_13),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            translate('edit_number'),
            style: AppStyle.defaultStyle.copyWith(
                color: AppColorsController().darkRed,
                fontWeight: AppFontWeight.bold,
                fontSize: AppFontSize.fontSize_13),
          ),
        ]),
      ),
    );
  }

  Widget _resendCodeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: _canResendCode
              ? () {
                  _resendCode();
                }
              : null,
          style: TextButton.styleFrom(foregroundColor: AppColorsController().black),
          child: Text(
            translate('resend_code'),
            textAlign: TextAlign.center,
          ),
        ),
        _remainingTimeWidget(),
      ],
    );
  }

  Widget _remainingTimeWidget() {
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          intl.DateFormat format = intl.DateFormat("mm:ss");
          DateTime now = DateTimeHelper.getStanderDate(DateTime.now().toUtc());
          DateTime estimated = DateTimeHelper.getStanderDate(eDate);
          Duration remaining = estimated.difference(now);
          String remainingTime;
          if (remaining.isNegative) {
            remainingTime = '';
            if (_canResendCode == false) {
              _canResendCode = true;
              _authBloc.refresh();
            }
          } else {
            if (_canResendCode == true) {
              _canResendCode = false;
              _authBloc.refresh();
            }
            remainingTime = '${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
          }
          if (remainingTime.isEmpty) {
            return SizedBox.shrink();
          }
          return Text(
            '$remainingTime',
            textAlign: TextAlign.center,
          );
        });
  }

  _resendCode() {
    FocusScope.of(context).unfocus();
    eDate = DateTime.now().toUtc().add(Duration(minutes: 2));

    _canResendCode = false;

    setState(() {
      _isLoading = true;
    });

    _authBloc.sendVerificationCode(
        AppConsts.countryCode, widget.phoneNumber.replaceAll(AppConsts.countryCode, '').replaceAll('+', ''),
        isChangePassword: widget.isChangePassword, onDone: () {
      setState(() {
        _isLoading = false;
      });
    }, onError: () {
      setState(() => _isLoading = false);
    });
  }
}
