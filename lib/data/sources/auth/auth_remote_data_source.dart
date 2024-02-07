import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:wadeema/core/models/empty_entity.dart';
import 'package:wadeema/core/shared_prefs/shared_prefs.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../../data/models/auth/auth_model.dart';
import '../../../blocs/application/application_bloc.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/models/empty_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  Future<Result<AuthenticateModel>> login(
    String email,
    String password,
  ) async {

    String deviceToken = DIManager.findDep<SharedPrefs>().getDeviceToken()!;
    String deviceType = DIManager.findDep<SharedPrefs>().getDeviceType()!;

    return await RemoteDataSource.request<AuthenticateModel>(
      converter: (model) => AuthenticateModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      data: {"email": email, "password": password,"device_token":deviceToken,"device_type":deviceType},
      url: AppEndpoints.authenticate,
    );
  }

  Future<Result<AuthenticateModel>> register({
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
    FormData formData;

    String deviceToken = DIManager.findDep<SharedPrefs>().getDeviceToken()!;
    String deviceType = DIManager.findDep<SharedPrefs>().getDeviceType()!;

    var profilePic ;
    if(  image != null)
      profilePic = await MultipartFile.fromFile(
        image.path! ?? "",
        filename: basename(image?.path ?? ""),
      );
    formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "user_name": userName,
      "email": email,
      "password": password,
      "gender": gender == 0 ? "female" : "male",
      "city_id": city,
      "mobile": phoneNumber,
      "full_mobile_number": phoneNumber,
      "about": aboutMe,
      // "latitude": addressLatitude,
      // "longitude": addressLongitude,
      "profile_pic": profilePic,
      "is_accept_terms": 1,
      "device_token":deviceToken,
      'is_mobile_verified':1
    });
    print('formData: ${formData.fields}');
    return await RemoteDataSource.request<AuthenticateModel>(
      converter: (model) => AuthenticateModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      formData: formData,
      url: AppEndpoints.register,
    );
  }

// Future<Result<EmptyModel>> refreshToken(params) async {
//   return await RemoteDataSource.request<EmptyModel>(
//     converter: (model) => EmptyModel(model),
//     method: HttpMethod.POST,
//     headers: {RemoteDataSource.requiresToken: false},
//     url: AppEndpoints.REFRESH_TOKEN,
//     data: params,
//   );
// }
//
  Future<Result<EmptyModel>> logout() async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: AppEndpoints.logout,
      headers: {RemoteDataSource.requiresToken: true},
    );
  }

  Future<Result<EmptyModel>> changePassword(
      String? email,String? mobile, String password) async {
    final body = {
      "password": password,
      "token": DIManager.findDep<SharedPrefs>().getToken()
    };

    if (mobile != null) {
      body['mobile'] = mobile;
    }

    if (email != null) {
      body['email'] = email;
    }

    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: true},
      data: body,
      url: AppEndpoints.resetPassword,
    );
  }

  Future<Result<EmptyModel>> forgetPassword(String email) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"email": email},
      url: AppEndpoints.forgetPassword,
      headers: {RemoteDataSource.requiresToken: false},
    );
  }

  Future<Result<EmptyModel>> sendVerificationCode(String countryCode,String mobile,bool isChangePassword) async {
    return await RemoteDataSource.request<EmptyModel>(
      method: HttpMethod.POST,
      converter: (model) => EmptyModel(model),
      data: {"country_code": countryCode, "mobile": mobile,},
      url: AppEndpoints.sendVerificationCode,
      headers: {RemoteDataSource.requiresToken: false},
    );
  }

  Future<Result<EmptyModel>> validateMobileNumber(String otpCode,String mobile,bool isChangePassword) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"mobile": mobile, "otp_code": otpCode, 'is_change_password': isChangePassword},
      url: AppEndpoints.validateMobileNumber,
      headers: {RemoteDataSource.requiresToken: false},
    );
  }

  @override
  Future<Result<EmptyModel>> deleteAccount() async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: AppEndpoints.logout,
      headers: {RemoteDataSource.requiresToken: true},
    );
  }


//
// @override
// Future<Result<bool>> firebase(String FCMtoken) async{
//   return await RemoteDataSource.request<bool>(
//     converter: (model) => model,
//     method: HttpMethod.PUT,
//     url: AppEndpoints.firebase,
//     data: {"token":FCMtoken}
//   );
// }
}

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<Result<AuthenticateModel>> login(
    String userName,
    String password,
  );

  Future<Result<AuthenticateModel>> register({
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

//
// Future<Result<EmptyModel>> refreshToken(params);
//
  Future<Result<EmptyModel>> logout();
  Future<Result<EmptyModel>> deleteAccount();

  Future<Result<EmptyModel>> changePassword(String? email,String? mobile, String password);

  Future<Result<EmptyModel>> forgetPassword(String email);

  Future<Result<dynamic>> sendVerificationCode(String countryCode,String mobile,bool isChangePassword);

  Future<Result<dynamic>> validateMobileNumber(String otpCode,String mobile,bool isChangePassword);


//
//
// Future<Result<bool>> firebase(String FCMtoken);
}
