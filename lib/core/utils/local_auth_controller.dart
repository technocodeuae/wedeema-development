import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'localization/app_localizations.dart';
import 'package:local_auth_platform_interface/types/auth_messages.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthController{
  static final LocalAuthController _self = LocalAuthController._();

  LocalAuthController._();

  factory LocalAuthController()=> _self;
  final LocalAuthentication localAuth = LocalAuthentication();
  // To check whether there is local authentication available on this device or not, call canCheckBiometrics:

  Future<bool> canCheckBiometrics() async{
    try {
      return await localAuth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  getAvailableBiometrics() async{
    try {
      List<BiometricType> availableBiometrics =
              await localAuth.getAvailableBiometrics();

      if (Platform.isIOS) {
            if (availableBiometrics.contains(BiometricType.face)) {
              // Face ID.
            } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
              // Touch ID.
            }
          }
    } on PlatformException {

    }
  }

  Future<bool> startBiometricsAuth() async{
    if(! await canCheckBiometrics()) return false;
    try {
      bool didAuthenticate =
          await localAuth.authenticate(
              localizedReason: translate('authenticate_localizedReason'),
            authMessages: <AuthMessages>[
              IOSAuthMessages(),
              AndroidAuthMessages(
                signInTitle: translate('authenticate_signInTitle'),
                cancelButton: translate('authenticate_cancelButton'),
                biometricSuccess: translate('authenticate_biometricSuccess'),
                biometricHint: translate('authenticate_biometricHint'),
                biometricNotRecognized: translate('authenticate_biometricNotRecognized'),
                biometricRequiredTitle: translate('authenticate_biometricRequiredTitle'),
              )
            ],
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
              sensitiveTransaction: true,
              biometricOnly: false,
            ),
          );
      return didAuthenticate;
    } on PlatformException{
      return false;
    }
  }
}