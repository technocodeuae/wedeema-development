import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../core/models/empty_model.dart';
import '../../models/list_user/list_user_model.dart';
import '../../models/more_info_profile/more_info_profile_model.dart';
import '../../models/other_profile/other_profile_model.dart';
import '../../models/profile/profile_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl();

  Future<Result<ProfileModel>> getProfile() async {
    return await RemoteDataSource.request<ProfileModel>(
      converter: (model) => ProfileModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.profile,
    );
  }

  Future<Result<ItemsUserModel>> editProfile(Map<String,dynamic> data) async {
    FormData formData;

    if(data["profile_pic"] != null)
      data["profile_pic"]  = await MultipartFile.fromFile(
        data["profile_pic"].path! ?? "",
      filename: basename(data["profile_pic"]?.path ?? ""),
    );

    log('body: $data');
    formData = FormData.fromMap(data);
    return await RemoteDataSource.request<ItemsUserModel>(
      converter: (model) => ItemsUserModel.fromJson(model),
      method: HttpMethod.POST,
      formData: formData,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.editProfile,
    );
  }


  Future<Result<MoreInfoProfileModel>> getMoreInfoProfile() async {
    return await RemoteDataSource.request<MoreInfoProfileModel>(
      converter: (model) => MoreInfoProfileModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.moreInfoProfile,
    );
  }

  Future<Result<OtherProfileModel>> getOtherProfile(int userId) async {
    return await RemoteDataSource.request<OtherProfileModel>(
      converter: (model) => OtherProfileModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.showProfile+"/${userId}",
    );
  }

  Future<Result<OtherProfileModel>> getProfileShare(String url) async {
    return await RemoteDataSource.request<OtherProfileModel>(
      converter: (model) => OtherProfileModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: "${url}",
    );
  }

  Future<Result<EmptyModel>> userFollow(int userId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"user_followed_id":userId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.followUser,
    );
  }
  Future<Result<EmptyModel>> userUnFollow(int userId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"user_followed_id":userId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.unFollowUser,
    );
  }
  Future<Result<EmptyModel>> userBlock(int userId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"blocked_user_id":userId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.blockUser,
    );
  }

  Future<Result<ListUserModel>> getALLFollowings (int page)async {
    return await RemoteDataSource.request<ListUserModel>(
      converter: (model) => ListUserModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.allFollowingsUser+"?page=${page}",
    );
  }

  Future<Result<ListUserModel>> getALLFollowers (int page)async {
    return await RemoteDataSource.request<ListUserModel>(
      converter: (model) => ListUserModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.allFollowersUser+"?page=${page}",
    );
  }

  Future<Result<ListUserModel>> getALLBlockers (int page)async {
    return await RemoteDataSource.request<ListUserModel>(
      converter: (model) => ListUserModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.allBlockersUser+"?page=${page}",
    );
  }

  Future<Result<EmptyModel>> userUnBlock(int userId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"blocked_user_id":userId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.unBlockUser,
    );
  }
}

abstract class ProfileRemoteDataSource {
  const ProfileRemoteDataSource();

  Future<Result<ProfileModel>> getProfile();
  Future<Result<MoreInfoProfileModel>> getMoreInfoProfile();
  Future<Result<ItemsUserModel>> editProfile(Map<String,dynamic> data);
  Future<Result<OtherProfileModel>> getOtherProfile(int userId);
  Future<Result<OtherProfileModel>> getProfileShare(String url);
  Future<Result<ListUserModel>> getALLFollowings(int page);
  Future<Result<ListUserModel>> getALLFollowers(int page);
  Future<Result<ListUserModel>> getALLBlockers(int page );
  Future<Result<EmptyModel>> userFollow(int userId);
  Future<Result<EmptyModel>> userUnFollow(int userId);
  Future<Result<EmptyModel>> userBlock(int userId);
  Future<Result<EmptyModel>> userUnBlock(int userId);
}
