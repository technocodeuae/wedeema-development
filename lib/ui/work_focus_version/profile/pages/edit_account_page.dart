import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/utils/file_manager_camera.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/check_icon.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/cities/cities_bloc.dart';
import '../../../../blocs/cities/states/cities_state.dart';
import '../../../../blocs/profile/states/update_profile_state.dart';
import '../../../../blocs/profile/update_profile_bloc.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../../../data/models/cities/entity/cities_entity.dart';
import '../../../../data/models/profile/entity/profile_entity.dart';
import '../../../map/map_screen.dart';
import '../../auth/pages/change_password_page.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/edit_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/build_text_field_widget.dart';
import '../../general/text_fields/text_field_decorator.dart';
import '../widget/image_profile_widget.dart';
import 'my_account_page.dart';

class EditAccountPage extends StatefulWidget {
  static const routeName = '/EditAccountPage';
  final ProfileEntity? data;

  const EditAccountPage({Key? key, this.data}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  dynamic selectedLocation;

  TextEditingController emailController = TextEditingController();
  String emailValue = "";

  TextEditingController userNameController = TextEditingController();
  String userNameValue = "";

  TextEditingController phoneNumberController = TextEditingController();
  String phoneNumberValue = "";

  TextEditingController aboutMeController = TextEditingController();

  String aboutMeValue = "";

  XFile? imageFileFront;

  String image = "";

  TextEditingController cityController = TextEditingController();
  CitiesEntity? cityValue = null;
  String cityValueString = "";
  int city_id = -1;
  bool isLoaderCity = false;
  List<CitiesEntity> cityData = [];
  final citiesBloc = DIManager.findDep<CitiesCubit>();

  double paddingBottom = 0;

  late StreamSubscription<bool> keyboardSubscription;
  var keyboardVisibilityController = KeyboardVisibilityController();


  @override
  void initState() {
    _buildValues();
    isLoaderCity = true;
    citiesBloc.getCities();

    // Query
    print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      paddingBottom = visible ? 300 : 0;
      setState(() {

      });
    });

  }

  final _profileBloc = DIManager.findDep<UpdateProfileCubit>();

  _buildValues() {
    print("phone number ${widget.data?.user?.mobile.toString()}");
    aboutMeController =
        TextEditingController(text: widget.data?.user?.about ?? "");
    aboutMeValue = widget.data?.user?.about ?? "";

    phoneNumberController =
        TextEditingController(text: widget.data?.user?.mobile?.replaceAll(AppConsts.countryCode, '') ?? "");
    phoneNumberValue = widget.data?.user?.mobile?.replaceAll(AppConsts.countryCode, '') ?? "";
    // print("phone number ${phoneNumberController.text.toString()}");

    emailController.text = widget.data?.user?.email ?? "";
    emailValue = widget.data?.user?.email ?? "";

    userNameController.text = widget.data?.user?.user_name ?? "";
    userNameValue = widget.data?.user?.user_name ?? "";

    cityController.text = widget.data?.user?.city ?? "";
  }

  bool _isLoader = false;
  bool _isEditable = false;
FocusNode _focusNode = FocusNode();
@override
void dispose(){
  _focusNode.dispose();
  super.dispose();
}
  void toggleEditable(){
    setState(() {
      _isEditable=!_isEditable;
    });
    // if(_isEditable){
    //
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: SafeArea(
          child: BackLongPress(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarWidget(
                  name: translate("profile"),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                          bloc: _profileBloc,
                          listener: (_, state) {

                            final editProfileState = state.editProfileState;
                            if (editProfileState is BaseFailState) {
                              CustomSnackbar.showErrorSnackbar(
                                editProfileState.error!,
                              );
                              setState(() {
                                _isLoader = false;
                              });
                            }
                            if (editProfileState is EditProfileSuccessState) {
                              final profileEntity = editProfileState.user;
                              DIManager.findDep<SharedPrefs>()
                                  .setImageProfile(profileEntity.profile_pic);
                              DIManager.findNavigator().pushReplacementNamed(
                                MyAccountPage.routeName,
                              );
                              setState(() {
                                _isLoader = false;
                              });
                            }
                          },
                          builder: (_, state) {
                            return Container(

                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.sp, vertical: 8.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16.sp,
                                  ),
                                  _buildEditImage(),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  BuildTextField(
                                    label: translate("user_name"),suffix: Icon(Icons.person,color: Colors.grey),
                                    isRequired: false,
                                    hint: userNameValue,
                                    controller: userNameController,
                                    onTextChanged: (value) {
                                      setState(() {
                                        userNameValue = value;
                                      });
                                    },
                                  ),
                                  BuildTextField(
                                    label: translate("email"),
                                    isRequired: false,
                                    hint: emailValue,
                                    controller: emailController,suffix: Icon(Icons.email_outlined,color: Colors.grey,),
                                    onTextChanged: (value) {
                                      setState(() {
                                        emailValue = value;
                                      });
                                    },
                                  ),


                                  Row(
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: BuildTextField(
                                          label: translate("phone_number"),
                                          isRequired: false,

                                          keyboardType: TextInputType.phone,fontSizeText: 15.sp,
                                          hint: phoneNumberValue,readOnly: !_isEditable,colorText: !_isEditable?Colors.grey:Colors.black  ,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(top: 3.5, ),
                                            child: Text(
                                              AppConsts.countryCodeWithEmoji,
                                              style: AppStyle.smallTitleStyle.copyWith(
                                                  color: Colors.grey, fontWeight: FontWeight.w500,fontSize: 16.sp),
                                            ),
                                          ),
                                          controller: phoneNumberController,
                                          onTextChanged: (value) {
                                            setState(() {
                                              phoneNumberValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: InkWell(
                                          onTap: () {
                                            toggleEditable();
                                            // Future.delayed(Duration(milliseconds: 100),(){
                                            //   FocusScope.of(context).requestFocus(FocusNode());
                                            // });
                                          },
                                          child: EditIcon(
                                            height: 25.sp,
                                            width: 24.sp,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                        for (int i = 0;
                                            i < cityData.length;
                                            i++) {
                                          if (cityData[i].id ==
                                              widget.data?.user?.city_id) {
                                            print("YEEEEEEEs");
                                            cityValue = cityData[i];
                                            break;
                                          }
                                        }
                                        isLoaderCity = true;
                                      }
                                      setState(() {});
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(6.0.sp),
                                          child: Text(
                                            translate("city") + " :",
                                            style: AppStyle.verySmallTitleStyle.copyWith(
                                              color: AppColorsController()
                                                  .textPrimaryColor,fontSize: 15.sp
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 19.sp),
                                          child: TextFieldDecorator(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.sp),
                                              child: DropdownButton<CitiesEntity>(
                                                value: cityValue,
                                                dropdownColor: AppColorsController().white,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cityValue = value!;
                                                  });
                                                },
                                                isExpanded: true,
                                                underline: Container(),
                                                items: cityData
                                                    ?.map((CitiesEntity item) {
                                                  return DropdownMenuItem<
                                                      CitiesEntity>(
                                                    value: item,
                                                    child: Text(item.title!,
                                                        style: AppFontStyle
                                                            .formFieldStyle
                                                            .copyWith(
                                                          color:
                                                              AppColorsController()
                                                                  .black,
                                                          fontWeight:
                                                              AppFontWeight
                                                                  .midLight,
                                                        )),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // BuildTextField(
                                  //   label: translate("city"),
                                  //   isRequired: false,
                                  //   hint: cityValue,
                                  //   controller: cityController,
                                  //   onTextChanged: (value) {
                                  //     setState(() {
                                  //       cityValue = value;
                                  //     });
                                  //   },
                                  // ),

                                  // BuildTextField(
                                  //   label: translate("about_me"),
                                  //   isRequired: false,
                                  //   hint: aboutMeValue,
                                  //   controller: aboutMeController,
                                  //   textDirection: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR? TextDirection.rtl:TextDirection.ltr,
                                  //   onTextChanged: (value) {
                                  //     setState(() {
                                  //       aboutMeValue = value;
                                  //     });
                                  //   },
                                  // ),
SizedBox(height: 14.sp,),
                                  Padding(
                                    padding:  EdgeInsets.only(right: 7.sp,bottom: 12.sp),
                                    child: Text(
                                      translate("about_me"),
                                      style: AppStyle.verySmallTitleStyle.copyWith(
                                        color: AppColorsController().textPrimaryColor,fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 18.sp),
                                    child: TextFormField(
                                      controller: aboutMeController, textDirection: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR? TextDirection.rtl:TextDirection.ltr,
                                      maxLines: null,    cursorColor: AppColorsController().scaffoldBGColor,
                                      decoration: InputDecoration(
                                        hintText: 'شرح قصير',
                                        filled: true,hintStyle:TextStyle(fontSize: 14.sp,),
                                        fillColor:AppColorsController().containerPrimaryColor,// لون الخلفية
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.1,color: AppColorsController().borderColor,// عرض البوردر
                                          ),
                                          borderRadius: BorderRadius.circular(Dimens.containerBorderRadius), // تعديل شكل الحقل
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.1,color: AppColorsController().borderColor,// عرض البوردر
                                          ),
                                          borderRadius: BorderRadius.circular(Dimens.containerBorderRadius), // تعديل شكل الحقل عند التركيز
                                        ),
                                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 20), // زيادة التباعد الرأسي لزيادة ارتفاع الحقل
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          aboutMeValue = value;
                                        });
                                      },
                                    ),
                                  ),


                                  // SizedBox(
                                  //   height: 8.sp,
                                  // ),
                                  // _buildAddress(),
                                ],
                              ),
                            );
                          },
                        ),

                        SizedBox(
                          height: 24.sp,
                        ),


                        _buttonBuild(),

                        SizedBox(
                          height: 24.sp + paddingBottom,
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
    );
  }

  _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate("address"),
          style: AppStyle.verySmallTitleStyle.copyWith(
            color: AppColorsController().textPrimaryColor,
          ),
        ),
        SizedBox(
          height: 6.sp,
        ),
        InkWell(
          onTap: () async {
            // void _selectLocation() async {
            selectedLocation = await Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => MapScreen()));
            if (selectedLocation != null) {
              setState(() {});
              print("YYYY");
              // Do something with the selected location
            }
          },
          child: Container(
            decoration: AppStyle.formFieldDecoration,
            height: 155.sp,
            width: 410.sp,
            padding: EdgeInsets.all(10.sp),
            child: selectedLocation != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(selectedLocation.latitude,
                          selectedLocation.longitude),
                    ),
                    markers: Set<Marker>.of([
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: LatLng(selectedLocation.latitude,
                            selectedLocation.longitude),
                        infoWindow: InfoWindow(title: 'Selected Location'),
                      ),
                    ]),
                  )
                : Container(),
          ),
        )
      ],
    );
  }

  void _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    XFile pickedFile = (await picker.pickImage(source: ImageSource.gallery))!;

    FileManagerCamera camera = FileManagerCamera();
    XFile? imageFileFront2= await  camera.imagePickerFromGallery(image: pickedFile);
    setState(()  {
      imageFileFront = imageFileFront2;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    XFile pickedFile = (await picker.pickImage(source: ImageSource.camera))!;

    FileManagerCamera camera = FileManagerCamera();
    XFile? imageFileFront2= await  camera.imagePickerFromGallery(image: pickedFile);


//     final inputFile = File(imageFileFront2!.path);
//     final inputBytes = await inputFile.readAsBytes();
//     final avifBytes = await encodeAvif(inputBytes);
//     final outputFile = XFile.fromData(avifBytes);
// print('--------------------------------------------------');
// print(outputFile.path);
// print('--------------------------------------------------');

    setState(()  {
      imageFileFront = imageFileFront2;
    });
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                      Icons.image_sharp,
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

  _showMore() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.sp),
      child: Column(
        children: [
          Row(
            children: [
              CheckIcon(
                width: 22.sp,
              ),
              SizedBox(
                width: 16.sp,
              ),
              Text(
                translate("show_email_to_other_user"),
                style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              CheckIcon(
                width: 22.sp,
              ),
              SizedBox(
                width: 16.sp,
              ),
              Text(
                translate("show_phone_number_to_other_user"),
                style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   //_profileBloc.close();
  //   super.dispose();
  // }


  // SaveIcon(
  //   height: 26.sp,
  //   width: 26.sp,
  // ),
  // SizedBox(
  //   width: 8.sp,
  // ),

  _buttonBuild() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButton(
            width: 160.sp,buttonColor: DIManager.findDep<AppColorsController>().buttonRedColor,
            height: 50.sp,
            child: Text(
              translate("change_password"),
              style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().white,
                  fontWeight: FontWeight.w800,fontSize: 16.5.sp
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onPressed: () {
              DIManager.findNavigator().pushNamed(
                ChangePasswordPage.routeName,
              );
            },
          ),
          SizedBox(
            width: 8.sp,
          ),
          AppButton(
            width: 160.sp,buttonColor: DIManager.findDep<AppColorsController>().buttonRedColor,
            height: 50.sp,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate("save"),
                  style: AppStyle.lightSubtitle.copyWith(
                    color: AppColorsController().white,
                    fontWeight: FontWeight.w800,fontSize: 16.5.sp
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                _isLoader ?SizedBox(width: 8.sp,):Container(),
                _isLoader ?Container(
                    width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().white,strokeWidth: 1.5,)):Container()
              ],
            ),
            onPressed: () {
              Map<String, dynamic> data = {};
              if (emailValue.isNotEmpty) {
                data["email"] = emailValue;
              }

              if (userNameValue.isNotEmpty) {
                data["user_name"] = userNameValue;
              }

              if (phoneNumberValue.isNotEmpty) {
                data["mobile"] = '${AppConsts.countryCode}$phoneNumberValue';
              }

              if (aboutMeValue.isNotEmpty) {
                data["about_me"] = aboutMeValue;
              }

              if (cityValue != null) {
                data["city_id"] = cityValue?.id;
              }

              if (selectedLocation != null) {
                data["longitude"] = selectedLocation.longitude;
                data["latitude"] = selectedLocation.latitude;
              }
              if (imageFileFront != null) {
                data["profile_pic"] = File(imageFileFront!.path);
              }

              setState(() {
                _isLoader = true;
              });

              _profileBloc.editProfile(data);
            },
          ),
        ],
      ),
    );
  }

  _buildEditImage() {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: EditIcon(
              height: 22.sp,
              width: 22.sp,
            ),
          ),
          imageFileFront != null
              ? ClipRRect(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 85.sp,
                      height: 85.sp,
                      child: Image.file(
                        File(imageFileFront!.path),

                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(80)),
                )
              : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ImageProfileWidget(
                    url: widget.data?.user?.profile_pic ?? "",
                    width: 85.sp,
                    height: 85.sp,
                  ),
              ),

        ],
      ),
    );
  }
}
