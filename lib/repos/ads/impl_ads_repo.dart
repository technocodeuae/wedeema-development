
import 'package:dio/dio.dart';

import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/ads/entity/ads_entity.dart';
import '../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../data/sources/ads/ads_remote_data_source.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';
import 'ads_repo_i.dart';

class AdsRepo extends BaseRepository implements AdsFacade {
  final AdsRemoteDataSource _aRD;
  final SharedPrefs _sp;

  AdsRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<AdsEntity>> getAllFilterAds(int page, List<Map<String,dynamic>> formData, int categoryId) async {
    final res = await _aRD.getAllFilterAds(page,formData,categoryId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<AdsEntity>> getSearchFilterAds(int page,String title,String category_id) async {
    final res = await _aRD.getSearchFilterAds(page,title,category_id);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<AdsEntity>> getCategoryAds(int page,int categoryId) async {
    final res = await _aRD.getCategoryAds(page,categoryId);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<AdsEntity>> getAllRecentAds(int page) async {
    final res = await _aRD.getAllRecentAds(page);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<AdsEntity>> getAllPopularAds(int page) async {
    final res = await _aRD.getAllPopularAds(page);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<AdsEntity>> getAllMostRatedAds(int page) async {
    final res = await _aRD.getAllMostRatedAds(page);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<AdsEntity>> getMyFavouriteAds(int page) async {
    final res = await _aRD.getMyFavouriteAds(page);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<AdsDetailsEntity>> getAds(int id) async {
    final res = await _aRD.getAds(id);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<AdsDetailsEntity>> getAdsShare(String url) async {
    final res = await _aRD.getAdsShare(url);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> likeAd(int adId)async {
    final res = await _aRD.likeAd(adId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> disLikeAd(int adId)async {
    final res = await _aRD.disLikeAd(adId);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<EmptyEntity>> favouriteAd(int adId)async {
    final res = await _aRD.favouriteAd(adId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> unFavouriteAd(int adId)async {
    final res = await _aRD.unFavouriteAd(adId);
    return mapModelToEntity(res);
  }

  // @override
  // Future<Result<EmptyEntity>> storeAds(ArgumentPolicy arg) async {
  //   final res = await _aRD.storeAds(arg);
  //   return mapModelToEntity(res);
  // }


}
