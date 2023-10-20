import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/core/constants/app_assets.dart';
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
import '../../../../core/constants/app_font.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../../../data/models/cities/entity/cities_entity.dart';
import '../../ads/widget/cities_drop_down.dart';
import '../../ads/widget/privacy_widget.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/pages/home_page.dart';

class CompleteInfoPage extends StatefulWidget {
  static const routeName = '/CompleteInfoPage';

  const CompleteInfoPage({Key? key,required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage> {
  dynamic selectedLocation;

  final TextEditingController phoneController = TextEditingController();


  TextEditingController emailController = TextEditingController();
  String emailValue = "";

  TextEditingController passwordController = TextEditingController();
  String passwordValue = "";

  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPasswordValue = "";

  TextEditingController firstNameController = TextEditingController();
  String firstNameValue = "";

  TextEditingController lastNameController = TextEditingController();
  String lastNameValue = "";

  TextEditingController usernameController = TextEditingController();
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

  final FocusNode focusNodeUsername = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();

  bool _hidePassword = true;

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
                  SizedBox(
                    height: 20.sp,
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
                          if (_isLoading == true &&registerState is RegisterSuccessState) {
                            setState(() {
                              _isLoading = false;
                            });
                            var snackBar = SnackBar(
                              content: Text(translate('sign_up_success')),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            DIManager.findNavigator().pushNamedAndRemoveUntil(
                              HomePage.routeName,
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _profileIcon(),
                            SizedBox(height: 24,),
                            _usernameField(),
                            SizedBox(height: 12,),
                            _emailField(),
                            SizedBox(height: 12,),
                            _emirateDropdown(),
                            SizedBox(height: 12,),
                            _passwordField(),
                            SizedBox(height: 32,),
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
            text: translate('complete_registration'),
            textStyle: AppStyle.titleStyle.copyWith(
                color: AppColorsController().white, fontWeight: AppFontWeight.bold, overflow: TextOverflow.ellipsis),
            textPadding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
            onPressed: () {
              _formKey.currentState!.save();

                if (emailValue.isEmpty) {
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

                  setState(() {
                    _isLoading = true;
                    _authBloc.register(
                        password: passwordValue,
                        email: emailValue,
                        firstName: firstNameValue,
                        lastName: lastNameValue,
                        aboutMe: aboutMeValue,
                        city: city_id,
                        gender: gender,
                        userName: userNameValue,
                        image: imageFileFront != null
                            ? File(imageFileFront!.path)
                            : null,
                        phoneNumber: widget.phoneNumber);
                  });

                }
            }),
      ),
    );
  }


  Widget _profileIcon(){
    return Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GestureDetector(
                onTap: () {
                  _openGallery(context);
                },
                child: imageFileFront != null
                    ? Image.file(
                        File(imageFileFront?.path ?? ''),
                        fit: BoxFit.fill,
                        width: 75.sp,
                        height: 75.sp,
                      )
                    : Image.asset(
                  AppAssets.profile,
                  height: 75.sp,
                  fit: BoxFit.cover,
                ),),
          ),
          if(imageFileFront != null) GestureDetector(
              onTap: (){
                setState(() {
                  imageFileFront = null;
                });
              },
              child: Icon(Icons.cancel,color: AppColorsController().red,))

        ],
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFileFront = pickedFile!;
    });
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

  Widget _usernameField() {
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
            controller: usernameController,
            focusNode: focusNodeUsername,
            nextFocusNode: focusNodeEmail,
            hint: translate('username'),
            maxLength: AppConsts.passwordMaxLength,
            isRequired: true,
            keyboardType: TextInputType.text,
            onTextChanged: (value) {
              setState(() {
                userNameValue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
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
            controller: emailController,
            focusNode: focusNodeEmail,
            hint: translate('email'),
            maxLength: AppConsts.passwordMaxLength,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
            onTextChanged: (value) {
              setState(() {
                emailValue = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _emirateDropdown() {
    return CitiesDropdownWidget(
      child: Container(
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
              controller: cityController,
              hint: cityValueString.isEmpty ? translate('emirate') : cityValueString,
              isRequired: true,
              readOnly: true,
              hintColor: cityValueString.isNotEmpty ? AppColorsController().black : null,
            ),
          ),
        ),
      ),
      selectedCity: city_id,
      onSelected: (value) {
        city_id = value?.id ?? -1;
        cityValueString = value?.title ?? '';
        cityController.text = value?.title ?? '';
        setState(() {

        });
      },
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


}
