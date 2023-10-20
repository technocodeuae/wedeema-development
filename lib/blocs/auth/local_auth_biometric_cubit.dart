import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../core/di/di_manager.dart';
import '../../core/shared_prefs/shared_prefs.dart';
import '../../core/utils/local_auth_controller.dart';

part 'local_auth_biometric_state.dart';

class LocalAuthBiometricCubit extends Cubit<LocalAuthBiometricState> {
  LocalAuthBiometricCubit() : super(LocalAuthBiometricInitState());

  int pinCodeTryCount = 0;
  int touchIdTryCount = 0;
  checkIfEnableDisableTouchId() async {
    final sharedPrefHelper = DIManager.findDep<SharedPrefs>();
    if (sharedPrefHelper.hasEnableDisableTouchId() != null) {
      if (sharedPrefHelper.hasEnableDisablePin() != null) {
        if (sharedPrefHelper.hasEnableDisablePin() == true) {
          emit(LocalAuthWithBiometricOrPinState());
        } else if (sharedPrefHelper.hasEnableDisableTouchId() == true) checkIfTheresAccount();
      } else if (sharedPrefHelper.hasEnableDisableTouchId() == true) checkIfTheresAccount();
    }
  }


  checkIfTheresAccount() async {
    final sharedPrefHelper = DIManager.findDep<SharedPrefs>();
    if (await sharedPrefHelper.hasBiometricAuth()) {
      if (touchIdTryCount < 3) {
        bool isAuth = await LocalAuthController().startBiometricsAuth();
        if (isAuth) {
          String? user = await sharedPrefHelper.getUserName();
          String? pass = await sharedPrefHelper.getPass();
          String? org = await sharedPrefHelper.getOrg();
          emit(LocalAuthWithBiometricState(
            user!,
            pass!,
            org!,
          ));
        } else {
          touchIdTryCount++;
        }
      }
    } else
      emit(LocalAuthWithoutBiometricState());
  }
}
