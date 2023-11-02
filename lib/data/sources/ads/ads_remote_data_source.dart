import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../core/models/empty_model.dart';
import '../../../ui/work_focus_version/ads/args/argument_policy.dart';
import '../../models/ads/ads_model.dart';
import '../../models/ads_details/ads_details_model.dart';

class AdsRemoteDataSourceImpl implements AdsRemoteDataSource {
  const AdsRemoteDataSourceImpl();

  Future<Result<AdsModel>> getAllFilterAds(int page, List<Map<String,dynamic>> formData, int categoryId) async {
    FormData data = FormData.fromMap({
      "properties":formData,
      "category_id":categoryId
    });
    print('formdata: ${data.fields}');
    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.POST,
      formData: data,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.allAdsFilter + "?page=${page}" ,
    );
  }

  Future<Result<AdsModel>> getSearchFilterAds(int page,String title,String category_id) async {
    
    // print("categoryId:" + categoryId.toString());
    FormData data = FormData.fromMap({
      "title":title,
      "category_id":category_id,
    });

    debugPrint('data: ${data.fields}');

    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.POST,
      formData: data,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.allAdsFilterSearch + "?page=${page}" ,
    );
  }
  Future<Result<AdsModel>> getCategoryAds(int page,int categoryId) async {

    FormData data = FormData.fromMap({
      "category_id":categoryId
    });
    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.GET,
      // formData: data,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.allCategoryAds + "?category_id=$categoryId&page=${page}" ,
    );
  }

  Future<Result<AdsModel>> getAllRecentAds(int page) async {
    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.allAdsRecent+ "?page=${page}",
    );
  }

  Future<Result<AdsModel>> getAllPopularAds(int page) async {
    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.allAdsPopular+ "?page=${page}",
    );
  }


  Future<Result<AdsModel>> getAllMostRatedAds(int page) async {
    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.allAdsMostRated+ "?page=${page}",
    );
  }


  Future<Result<AdsModel>> getMyFavouriteAds(int page) async {
    return await RemoteDataSource.request<AdsModel>(
      converter: (model) => AdsModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.myFavouriteAds+ "?page=${page}",
    );
  }


  Future<Result<AdsDetailsModel>> getAds(int id) async {
    return await RemoteDataSource.request<AdsDetailsModel>(
      converter: (model) => AdsDetailsModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.Ads + "/${id}",
    );
  }


  Future<Result<AdsDetailsModel>> getAdsShare(String url) async {
    return await RemoteDataSource.request<AdsDetailsModel>(
      converter: (model) => AdsDetailsModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: "${url}",
    );
  }
  Future<Result<EmptyModel>> likeAd(int adId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"ad_id":adId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.likeAd,
    );
  }
  Future<Result<EmptyModel>> disLikeAd(int adId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"ad_id":adId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.dislikeAd,
    );
  }
  Future<Result<EmptyModel>> favouriteAd(int adId) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"ad_id":adId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.favouriteAd,
    );
  }
  Future<Result<EmptyModel>> unFavouriteAd(int adId) async {

    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"ad_id":adId},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.unFavouriteAd,
    );

  }

}

abstract class AdsRemoteDataSource {
  const AdsRemoteDataSource();

  Future<Result<AdsModel>> getAllFilterAds(int page, List<Map<String,dynamic>> formData, int categoryId);
  Future<Result<AdsModel>> getSearchFilterAds(int page,String title,String category_id);
  Future<Result<AdsModel>> getCategoryAds(int page,int categoryId);
  Future<Result<AdsModel>> getAllRecentAds(int page);
  Future<Result<AdsModel>> getAllPopularAds(int page);
  Future<Result<AdsModel>> getAllMostRatedAds(int page);
  Future<Result<AdsModel>> getMyFavouriteAds(int page);
  Future<Result<AdsDetailsModel>> getAds(int id);
  Future<Result<AdsDetailsModel>> getAdsShare(String url);
  Future<Result<EmptyModel>> likeAd(int adId);
  Future<Result<EmptyModel>> disLikeAd(int adId);
  Future<Result<EmptyModel>> favouriteAd(int adId);
  Future<Result<EmptyModel>> unFavouriteAd(int adId);


  // Future<Result<EmptyModel>> storeAds(ArgumentPolicy arg);
}
