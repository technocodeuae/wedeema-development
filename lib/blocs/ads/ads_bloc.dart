
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/ads/states/ads_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/ads/ads_repo_i.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdsFacade adsRepo;

  AdsCubit(
    this.adsRepo,
  ) : super(AdsState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Future<void> getAllFilterAds(int page, List<Map<String,dynamic>> formData, int categoryId) async {
    emit(state.copyWith(getAllFilterAdsState: BaseLoadingState()));
    final result = await adsRepo.getAllFilterAds(page,formData,categoryId);
    if (result.hasDataOnly) {
      emit(state.copyWith(getAllFilterAdsState: GetAllFilterAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllFilterAdsState: BaseFailState(
            result.error,
            callback: () => this.getAllFilterAds(page,formData,categoryId),
          ),
        ),
      );
    }
  }
  Future<void> getSearchFilterAds(int page,String title,int category_id) async {
    emit(state.copyWith(getAllSearchAdsState: BaseLoadingState()));
    final result = await adsRepo.getSearchFilterAds(page, title,category_id);
    print('02198398129083901283098129038920183098129038012830981209382109321908');
    print(result.data!.data!);
    print('02198398129083901283098129038920183098129038012830981209382109321908');
    if (result.hasDataOnly) {
      emit(state.copyWith(getAllSearchAdsState: GetSearchFilterAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllSearchAdsState: BaseFailState(
            result.error,
            callback: () => this.getSearchFilterAds(page, title,category_id),
          ),
        ),
      );
    }
  }
  Future<void> getCategoryAds(int page,int categoryId) async {
    emit(state.copyWith(getCategoryAdsState: BaseLoadingState()));
    final result = await adsRepo.getCategoryAds(page, categoryId);
    if (result.hasDataOnly) {
      emit(state.copyWith(getCategoryAdsState: GetCategoryAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getCategoryAdsState: BaseFailState(
            result.error,
            callback: () => this.getCategoryAds(page, categoryId),
          ),
        ),
      );
    }
  }


  Future<void> getAllMostRatedAds(int page) async {
    emit(state.copyWith(getAllMostRatedAdsState: BaseLoadingState()));
    final result = await adsRepo.getAllMostRatedAds(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(getAllMostRatedAdsState: GetAllMostRatedAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllMostRatedAdsState: BaseFailState(
            result.error,
            callback: () => this.getAllMostRatedAds(page),
          ),
        ),
      );
    }
  }
  Future<void> getMyFavouriteAds(int page) async {

    emit(state.copyWith(getMyFavouriteAdsState: BaseLoadingState()));
    final result = await adsRepo.getMyFavouriteAds(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(getMyFavouriteAdsState: GetAllMyFavouriteAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getMyFavouriteAdsState: BaseFailState(
            result.error,
            callback: () => this.getMyFavouriteAds(page),
          ),
        ),
      );
    }
  }

  Future<void> getAllPopularAds(int page) async {
    emit(state.copyWith(getAllPopularAdsState: BaseLoadingState()));
    final result = await adsRepo.getAllPopularAds(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(getAllPopularAdsState: GetAllPopularAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllPopularAdsState: BaseFailState(
            result.error,
            callback: () => this.getAllPopularAds(page),
          ),
        ),
      );
    }
  }

  Future<void> getAllRecentAds(int page) async {
    emit(state.copyWith(getAllRecentAdsState: BaseLoadingState()));
    final result = await adsRepo.getAllRecentAds(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(getAllRecentAdsState: GetAllRecentAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllRecentAdsState: BaseFailState(
            result.error,
            callback: () => this.getAllRecentAds(page),
          ),
        ),
      );
    }
  }

  Future<void> getAds(int id) async {
    emit(state.copyWith(getAdsDetailsState: BaseLoadingState()));
    final result = await adsRepo.getAds(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(getAdsDetailsState: AdsDetailsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAdsDetailsState: BaseFailState(
            result.error,
            callback: () => this.getAds(id),
          ),
        ),
      );
    }
  }
  Future<void> getAdsShare(String url) async {
    emit(state.copyWith(getAdsShareState: BaseLoadingState()));
    final result = await adsRepo.getAdsShare(url);
    if (result.hasDataOnly) {
      emit(state.copyWith(getAdsShareState: GetAdsShareSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAdsShareState: BaseFailState(
            result.error,
            callback: () => this.getAdsShare(url),
          ),
        ),
      );
    }
  }
  Future<void> likeAd(int adId) async {
    emit(state.copyWith(likeAdState: BaseLoadingState()));
    final result = await adsRepo.likeAd(adId);
    if (result.hasDataOnly) {
      emit(state.copyWith(likeAdState: LikeAdSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          likeAdState: BaseFailState(
            result.error,
            callback: () => this.likeAd(adId),
          ),
        ),
      );
    }
  }
  Future<void> disLikeAd(int adId) async {
    emit(state.copyWith(disLikeAdState: BaseLoadingState()));
    final result = await adsRepo.disLikeAd(adId);
    if (result.hasDataOnly) {
      emit(state.copyWith(disLikeAdState: DisLikeAdSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          disLikeAdState: BaseFailState(
            result.error,
            callback: () => this.disLikeAd(adId),
          ),
        ),
      );
    }
  }

bool isFavourite = false;
  Future<void> favouriteAd(int adId) async {
    emit(state.copyWith(favouriteAdState: BaseLoadingState()));
    final result = await adsRepo.favouriteAd(adId);
    if (result.hasDataOnly) {
      emit(state.copyWith(favouriteAdState: FavouriteAdSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          favouriteAdState: BaseFailState(
            result.error,
            callback: () => this.favouriteAd(adId),
          ),
        ),
      );
    }
  }
  Future<void> unFavouriteAd(int adId) async {
    emit(state.copyWith(unFavouriteAdState: BaseLoadingState()));
    final result = await adsRepo.unFavouriteAd(adId);
    if (result.hasDataOnly) {
      isFavourite = true;
      emit(state.copyWith(unFavouriteAdState: UnFavouriteAdSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          unFavouriteAdState: BaseFailState(
            result.error,
            callback: () => this.unFavouriteAd(adId),
          ),
        ),
      );
    }
  }
}
