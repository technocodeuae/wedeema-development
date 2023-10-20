import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/check_icon.dart';

import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../blocs/cities/cities_bloc.dart';
import '../../../../blocs/cities/states/cities_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../../../data/models/cities/entity/cities_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/build_text_field_widget.dart';
import '../../general/text_fields/text_field_decorator.dart';
import '../../home/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUpPageNew';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  dynamic selectedLocation;

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
  final citiesBloc = DIManager.findDep<CitiesCubit>();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoaderCity = true;
    citiesBloc.getCities();
  }

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
                    name: translate("register"),
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 32.sp),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.sp,
                                ),
                                BuildTextField(
                                  label: translate("first_name"),
                                  isRequired: true,
                                  controller: firstNameController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      firstNameValue = value;
                                    });
                                  },
                                ),
                                BuildTextField(
                                  label: translate("last_name"),
                                  isRequired: true,
                                  controller: lastNameController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      lastNameValue = value;
                                    });
                                  },
                                ),
                                BuildTextField(
                                  label: translate("user_name"),
                                  isRequired: true,
                                  controller: userNameController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      userNameValue = value;
                                    });
                                  },
                                ),
                                BuildTextField(
                                  label: translate("email"),
                                  isRequired: true,
                                  controller: emailController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      emailValue = value;
                                    });
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 43.sp),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0.sp),
                                        child: Text(
                                          translate("gender") + "* :",
                                          style: AppStyle.verySmallTitleStyle
                                              .copyWith(
                                            color: AppColorsController()
                                                .textPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      TextFieldDecorator(
                                        width: 350.sp,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    gender = 1;
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        translate("female"),
                                                        style: AppStyle
                                                            .verySmallTitleStyle
                                                            .copyWith(
                                                          color:
                                                              AppColorsController()
                                                                  .textPrimaryColor,
                                                        ),
                                                      ),
                                                      gender == 1
                                                          ? CheckIcon(
                                                              width: 13.sp,
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                  height: 30.sp,
                                                  width: 98.sp,
                                                  decoration: AppStyle
                                                      .formFieldDecoration,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.sp,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    gender = 0;
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        translate("male"),
                                                        style: AppStyle
                                                            .verySmallTitleStyle
                                                            .copyWith(
                                                          color:
                                                              AppColorsController()
                                                                  .textPrimaryColor,
                                                        ),
                                                      ),
                                                      gender == 0
                                                          ? CheckIcon(
                                                              width: 13.sp,
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                  height: 30.sp,
                                                  width: 98.sp,
                                                  decoration: AppStyle
                                                      .formFieldDecoration,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BuildTextField(
                                  label: translate("password"),
                                  isRequired: true,
                                  controller: passwordController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      passwordValue = value;
                                    });
                                  },
                                ),
                                BuildTextField(
                                  label: translate("confirm_password"),
                                  isRequired: true,
                                  controller: confirmPasswordController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      confirmPasswordValue = value;
                                    });
                                  },
                                ),

                                BlocListener<CitiesCubit, CitiesState>(
                                  bloc: citiesBloc,
                                  listener: (context, state) {
                                    final citiesState = state.getCitiesState;

                                    if (isLoaderCity == true &&
                                        citiesState is CitiesSuccessState) {
                                      cityData = (state.getCitiesState
                                              as CitiesSuccessState)
                                          .cities;
                                      cityValue = cityData[0];
                                      isLoaderCity = true;
                                    }
                                    setState(() {});
                                  },
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0.sp),
                                        child: Text(
                                           translate("city")+ "* :",
                                          style: AppStyle.verySmallTitleStyle.copyWith(
                                            color: AppColorsController().textPrimaryColor,
                                          ),
                                        ),
                                      ),

                                      TextFieldDecorator(
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 24.sp),
                                          child: DropdownButton<CitiesEntity>(
                                            value: cityValue,

                                            onChanged: (value) {
                                              print(value!.title.toString());
                                              setState(() {
                                                cityValue = value!;
                                              });
                                            },
                                            isExpanded: true,
                                            underline: Container(),
                                            items: cityData?.map((CitiesEntity item) {
                                              return DropdownMenuItem<CitiesEntity>(
                                                value: item,
                                                child: Text(item.title!,
                                                    style: AppFontStyle.formFieldStyle
                                                        .copyWith(
                                                      color: AppColorsController()
                                                          .black,
                                                      fontWeight: AppFontWeight.midLight,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BuildTextField(
                                  label: translate("phone_number"),
                                  isRequired: false,
                                  controller: phoneNumberController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      phoneNumberValue = value;
                                    });
                                  },
                                ),
                                BuildTextField(
                                  label: translate("about_me"),
                                  isRequired: false,
                                  controller: aboutMeController,
                                  onTextChanged: (value) {
                                    setState(() {
                                      aboutMeValue = value;
                                    });
                                  },
                                ),
                                _buildImageAndAddress(),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                _buildButton(),
                                SizedBox(
                                  height: 20.sp,
                                ),
                              ],
                            ),
                          ),
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

  _buildImageAndAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44.sp, vertical: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       translate("address") + "* :",
          //       style: AppStyle.verySmallTitleStyle.copyWith(
          //         color: AppColorsController().textPrimaryColor,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 6.sp,
          //     ),
          //     InkWell(
          //       onTap: () async {
          //         // void _selectLocation() async {
          //         selectedLocation = await Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => MapScreen()));
          //         if (selectedLocation != null) {
          //           setState(() {});
          //           print("YYYY");
          //           // Do something with the selected location
          //         }
          //         // }
          //         // DIManager.findNavigator().pushNamed(
          //         //   MapPage.routeName,
          //         // );
          //       },
          //       child: Container(
          //         decoration: AppStyle.formFieldDecoration,
          //         height: 155.sp,
          //         width: 145.sp,
          //         padding: EdgeInsets.all(10.sp),
          //         child: selectedLocation != null
          //             ? GoogleMap(
          //                 initialCameraPosition: CameraPosition(
          //                   target: LatLng(selectedLocation.latitude,
          //                       selectedLocation.longitude),
          //                 ),
          //                 markers: Set<Marker>.of([
          //                   Marker(
          //                     markerId: MarkerId('selected_location'),
          //                     position: LatLng(selectedLocation.latitude,
          //                         selectedLocation.longitude),
          //                     infoWindow:
          //                         InfoWindow(title: 'Selected Location'),
          //                   ),
          //                 ]),
          //               )
          //             : Container(),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(width: 8.sp,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate("image") + " :",
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().textPrimaryColor,
                ),
              ),
              SizedBox(
                height: 6.sp,
              ),
              InkWell(
                onTap: () {
                  _showChoiceDialog(context);
                },
                child: Container(
                  decoration: AppStyle.formFieldDecoration,
                  height: 155.sp,
                  width: 145.sp,
                  padding: EdgeInsets.all(8.sp),
                  child: imageFileFront != null
                      ? Image.file(
                          File(imageFileFront!.path!),
                          fit: BoxFit.fill,
                        )
                      : Container(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildButton() {
    return AppButton(
      width: 150.sp,
      height: 44.sp,
      childPadding: EdgeInsets.symmetric(horizontal: 15.sp),
      onPressed: () {
        _formKey.currentState!.save();

        if (passwordValue.toString() != confirmPasswordValue.toString()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(translate("passwords_don't_match")),
          ));
        } else {
          if (firstNameValue.isEmpty ||
              lastNameValue.isEmpty ||
              userNameValue.isEmpty ||
              emailValue.isEmpty ||
              passwordValue.isEmpty ||
              cityValue == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(translate("please_fill_all_requirement_data")),
            ));
          } else {
            setState(() {
              _isLoading = true;
              _authBloc.register(
                  password: passwordValue,
                  email: emailValue,
                  firstName: firstNameValue,
                  lastName: lastNameValue,
                  aboutMe: aboutMeValue,
                  city: cityValue!.id!,
                  gender: gender,
                  userName: userNameValue,
                  image: imageFileFront != null
                      ? File(imageFileFront!.path)
                      : null,
                  phoneNumber: phoneNumberValue);
            });
          }
        }
      },
      child: Text(
        translate("register"),
        style: AppStyle.verySmallTitleStyle.copyWith(
          color: AppColorsController().textPrimaryColor,
          fontWeight: AppFontWeight.midLight,
        ),
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

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFileFront = pickedFile!;
    });
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              translate("choose_option"),
              style: TextStyle(
                color: AppColorsController().primaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: AppColorsController().primaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text(translate("gallery")),
                    leading: Icon(
                      Icons.account_box,
                      color: AppColorsController().primaryColor,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: AppColorsController().primaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text(translate("camera")),
                    leading: Icon(
                      Icons.camera,
                      color: AppColorsController().primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
