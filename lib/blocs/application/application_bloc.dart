import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../blocs/application/states/version/version_state.dart';

import '../../../../blocs/application/states/application_state.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/errors/app_error_handler/app_error_handler.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';

part 'extensions/version_extension.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.initialState());

//  UserEntity? _userProfile;

  // setUserModel(UserEntity userEntity) {
  //   this._userProfile = userEntity;
  // }
  //
  // UserEntity getUserProfile() {
  //   if (_userProfile == null)
  //     _userProfile = DIManager.findDep<ProfileCubit>().profile;
  //
  //   return _userProfile!;
  // }

  /// This method
  Future<void> init() async {}

  final List<Locale> supportedLanguages = [
    Locale(AppConsts.LANG_EN),
    Locale(AppConsts.LANG_AR)
  ];
///
  Locale _appLanguage =
      Locale(DIManager.findDep<SharedPrefs>().appLanguageCode.val);



  set appLanguage(Locale value) {
    _appLanguage = value;
    Get.updateLocale(value);
    // save language in shared prefs
    DIManager.findDep<SharedPrefs>().appLanguageCode.val = value.languageCode;
  }


  Locale get appLanguage => _appLanguage;

  void changeLanguage(String langCode) {
    appLanguage = supportedLanguages
        .firstWhere((element) => element.languageCode == langCode);
  }



  void onAppInit() {
    print('onAppInit .. ');

    /// init error catcher
    AppErrorHandler.init();

    _setPrimaryColor();

    /// validate app version
    checkVersion();
  }

  void _setPrimaryColor() {
    print('SET PRIM COLOR');
  }


  refreshColor() {
    print('refreshColor ..');
    emit(state.copyWith());
  }

  void onHomeDrawer(bool isOpened) {
    print('onHomeDrawer ..');
    emit(state.copyWith(isHomeDrawerOpened: isOpened));
  }

  Future isBottomBarShowed(bool isOpened) async {
    emit(state.copyWith(isBottomBarShowed: isOpened));
    return null;
  }

  void setSideDrawer(bool isShowed) {
    print('setSideDrawer .. $isShowed');
    //  if(state.isSideDrawerShowed != isShowed)
    emit(state.copyWith(isSideDrawerShowed: isShowed));
  }

  Future onOverallDrawerChanged(Function setHandleOfDrawer) async {
    emit(
      state.copyWith(setHandleOfDrawer: setHandleOfDrawer),
    );
    return null;
  }

  Function? getOverallDrawerHandler() {
    return state.setHandleOfDrawer;
  }

  @override
  void emit(ApplicationState state) {
    print('app emit ..');
    super.emit(state);
  }
}


class ThemeProvider extends ChangeNotifier {


  String _appMode =
      DIManager.findDep<SharedPrefs>().appMode.val;

  String get appMode => _appMode;

   refreshDarkLightModeColor(String mode) {
    print('refreshDarkLightColor ..');
    appMode = mode;
   }

  set appMode(String value) {
    _appMode = value;
    // save language in shared prefs
    DIManager.findDep<SharedPrefs>().appMode.val = value;
    notifyListeners();
    Get.forceAppUpdate();
  }


}

