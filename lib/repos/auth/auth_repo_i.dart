
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:wadeema/data/models/auth/entity/auth_entity.dart';

import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';

abstract class AuthFacade {
  Future<Result<AuthenticateEntity>> authenticate({
    required String email,
    required String password,
  });

  Future<Result<AuthenticateEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String userName,
     String? phoneNumber,
    required int city,
    // required String addressLatitude,
    // required String addressLongitude,
    String? aboutMe,
    File? image,
    required int gender,
  });

  Future<Result<EmptyEntity>> logout();
  Future<Result<EmptyEntity>> deleteAccount(BuildContext context);
  Future<Result<EmptyEntity>> forgetPassword(String email);
  Future<Result<EmptyEntity>> changePassword(String? email, String? mobile, String password);
  Future<Result<dynamic>> sendVerificationCode(String countryCode,String mobile,bool isChangePassword);
  Future<Result<dynamic>> validateMobileNumber(String otpCode,String mobile,bool isChangePassword);

  // Future<Result<EmptyEntity>> refreshToken();

  // Future<Result<bool>> firebase({
  //   required String token,
  // });
}
