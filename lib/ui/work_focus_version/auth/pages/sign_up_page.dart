import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/send_otp_page.dart';
import 'package:wadeema/ui/work_focus_version/general/text_fields/text_field_widget.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../../../data/models/cities/entity/cities_entity.dart';
import '../../ads/widget/privacy_widget.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUpPage';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  dynamic selectedLocation;

  final TextEditingController phoneController = TextEditingController();


  TextEditingController emailController = TextEditingController();
  String phoneValue = "";

  TextEditingController passwordController = TextEditingController();
  String passwordValue = "";

  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPasswordValue = "";

  TextEditingController firstNameController = TextEditingController();
  String firstNameValue = "";

  TextEditingController lastNameController = TextEditingController();
  String lastNameValue = "";

  TextEditingController userNameController = TextEditingController();
  String userNameValue = "";

  TextEditingController cityController = TextEditingController();
  CitiesEntity? cityValue = null;
  String cityValueString = "";
  int city_id = -1;
  bool isLoaderCity = false;
  List<CitiesEntity> cityData = [];

  TextEditingController phoneNumberController = TextEditingController();
  String phoneNumberValue = "";

  TextEditingController aboutMeController = TextEditingController();

  String aboutMeValue = "";

  int gender = 0;

  XFile? imageFileFront;

  final _authBloc = DIManager.findDep<AuthCubit>();
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();


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
              child: Stack(
                children: [
                  Column(
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
                      SizedBox(
                        height: 50.sp,
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: BlocListener<AuthCubit, AuthState>(
                            bloc: _authBloc,
                            listener: (_, state) {
                              final registerState = state.registerState;

                              if (_isLoading == true &&registerState is BaseFailState) {
                                CustomSnackbar.showErrorSnackbar(
                                  registerState.error!,
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                              if (_isLoading == true &&registerState is VerificationCodeSuccessState) {

                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _titleWidget(),
                                SizedBox(height: 24,),
                                _numberField(),
                                SizedBox(height: 94,),
                                PrivacyWidget(color: AppColorsController().black),
                                SizedBox(height: 16,),
                                _buildButton(),
                                _signInWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 60.sp,
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
    );
  }

  _buildButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 24.sp,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
        child: NewButton(
            text: translate('next'),
            textStyle: AppStyle.titleStyle.copyWith(
                color: AppColorsController().white, fontWeight: AppFontWeight.bold, overflow: TextOverflow.ellipsis),
            textPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
            onPressed: () {
              _formKey.currentState!.save();

                if (phoneValue.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(translate("please_fill_all_requirement_data")),
                  ));
                } else {
                  if (!categoriesBloc.isAcceptPrivacy) {
                    var snackBar = SnackBar(
                      content: Text(translate('please_agree_with_terms')),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }

                  FocusScope.of(context).unfocus();

                  setState(() {
                    _isLoading = true;
                  });
                  _authBloc.sendVerificationCode(AppConsts.countryCode, phoneValue,onDone: (){
                    setState(() {
                      _isLoading = false;
                    });
                    DIManager.findNavigator().pushNamed(
                        SendOtpPage.routeName,
                        arguments: {'phone_number':'+${AppConsts.countryCode}$phoneValue'}
                    );
                  },onError: (){
                    setState(() {
                      _isLoading = false;
                    });
                  });
                }
            }),
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
            translate('register'),
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

  Widget _signInWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(foregroundColor: AppColorsController().primaryColor),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            translate('do_have_account'),
            style: AppStyle.smallTitleStyle.copyWith(
              color: AppColorsController().black,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          SizedBox(width: 4,),
          Text(
            translate('sign_in_now'),
            style: AppStyle.smallTitleStyle.copyWith(
              color: AppColorsController().darkRed,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }


}
