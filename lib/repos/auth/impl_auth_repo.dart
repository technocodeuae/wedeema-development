
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import 'auth_repo_i.dart';

class AuthRepo extends BaseRepository implements AuthFacade {
  final AuthRemoteDataSource _aRD;
  final SharedPrefs _sp;

  AuthRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<AuthenticateEntity>> authenticate({
    required String email,
    required String password,
  }) async {
    final res = await _aRD.login(email, password);
    // _sp.setAuth(res.data);
    return mapModelToEntity(res);
  }


  @override
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
  }) async {
    final res = await _aRD.register(
      lastName: lastName,
       email:email,
       password:password,
       userName:userName,
       phoneNumber:phoneNumber,
       city:city,
       // addressLongitude:addressLongitude,
       // addressLatitude:addressLatitude,
       aboutMe:aboutMe,
       image:image,
       gender:gender, firstName: firstName,);
    // _sp.setAuth(res.data);
    return mapModelToEntity(res);
  }


@override
Future<Result<EmptyEntity>> changePassword(String? email,String? mobile, String password) async{

    final res = await _aRD.changePassword(email,mobile, password);

    return mapModelToEntity(res);
}

  @override
  Future<Result<EmptyEntity>> forgetPassword(String email) async {
      final res = await _aRD.forgetPassword(email);

      return mapModelToEntity(res);
  }
//   @override
//   Future<Result<bool>> firebase({required String token}) {
//     // TODO: implement firebase
//     throw UnimplementedError();
//   }

  @override
  Future<Result<EmptyEntity>> logout() async {
    final res = await _aRD.logout();
    return mapModelToEntity(res);
  }

  @override
  Future<Result<dynamic>> sendVerificationCode(String countryCode,String mobile,bool isChangePassword) async {
    final res = await _aRD.sendVerificationCode(countryCode, mobile, isChangePassword);
    return res;
  }

  @override
  Future<Result<dynamic>> validateMobileNumber(String otpCode,String mobile,bool isChangePassword) async {
    final res = await _aRD.validateMobileNumber(otpCode, mobile,isChangePassword);
    return res;
  }

  @override
  Future<Result<EmptyEntity>> deleteAccount() async {
    final res = await _aRD.deleteAccount();
    return mapModelToEntity(res);
  }
  //
  // @override
  // Future<Result<EmptyEntity>> refreshToken() async {
  //   print('refreshToken before authModel -_-}');
  //   final authModel = _sp.getAuth();
  //   print('refreshToken authModel between ${authModel}');
  //   final res = await _aRD.refreshToken(authModel?.toJson());
  //   print('refreshToken after  authModel  ${res.data?.data}');
  //   _sp.setToken(res.data?.data);
  //   return mapModelToEntity(res);
  // }
}
