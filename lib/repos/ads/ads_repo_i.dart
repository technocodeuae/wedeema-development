
import 'package:dio/dio.dart';
import 'package:wadeema/data/models/auth/entity/auth_entity.dart';

import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../data/models/ads/entity/ads_entity.dart';
import '../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';

abstract class AdsFacade {

  Future<Result<AdsEntity>> getAllFilterAds(int page, List<Map<String,dynamic>> formData, int categoryId);
  Future<Result<AdsEntity>> getSearchFilterAds(int page,String title);
  Future<Result<AdsEntity>> getCategoryAds(int page,int categoryId);
  Future<Result<AdsEntity>> getAllRecentAds(int page);
  Future<Result<AdsEntity>> getAllPopularAds(int page);
  Future<Result<AdsEntity>> getAllMostRatedAds(int page);
  Future<Result<AdsEntity>> getMyFavouriteAds(int page);
  Future<Result<AdsDetailsEntity>> getAds(int id);
  Future<Result<AdsDetailsEntity>> getAdsShare(String url);
  Future<Result<EmptyEntity>> likeAd(int adId);
  Future<Result<EmptyEntity>> disLikeAd(int adId);
  Future<Result<EmptyEntity>> favouriteAd(int adId);
  Future<Result<EmptyEntity>> unFavouriteAd(int adId);
  // Future<Result<EmptyEntity>> storeAds(ArgumentPolicy arg);
}
