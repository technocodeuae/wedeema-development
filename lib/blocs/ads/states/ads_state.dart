import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/ads/entity/ads_entity.dart';

class AdsState {
  GeneralState getAllFilterAdsState;
  GeneralState getCategoryAdsState;
  GeneralState getAllMostRatedAdsState;
  GeneralState getAllPopularAdsState;
  GeneralState getAllRecentAdsState;
  GeneralState getAllSearchAdsState;
  GeneralState getMyFavouriteAdsState;
  GeneralState getAdsDetailsState;
  GeneralState favouriteAdState;
  GeneralState unFavouriteAdState;
  GeneralState likeAdState;
  GeneralState disLikeAdState;
  GeneralState getAdsShareState;

  AdsState({
    required this.getAllFilterAdsState,
    required this.getAllMostRatedAdsState,
    required this.getAllPopularAdsState,
    required this.getMyFavouriteAdsState,
    required this.getAllRecentAdsState,
    required this.getAllSearchAdsState,
    required this.getAdsDetailsState,
    required this.favouriteAdState,
    required this.likeAdState,
    required this.unFavouriteAdState,
    required this.disLikeAdState,
    required this.getAdsShareState,
    required this.getCategoryAdsState,
  });

  factory AdsState.initialState() => AdsState(
        getAllSearchAdsState: BaseInitState(),
        getAllRecentAdsState: BaseInitState(),
        getAllPopularAdsState: BaseInitState(),
        getAllMostRatedAdsState: BaseInitState(),
        getAllFilterAdsState: BaseInitState(),
        getAdsDetailsState: BaseInitState(),
        favouriteAdState: BaseInitState(),
        likeAdState: BaseInitState(),
        disLikeAdState: BaseInitState(),
        unFavouriteAdState: BaseInitState(),
        getAdsShareState: BaseInitState(),
        getMyFavouriteAdsState: BaseInitState(),
        getCategoryAdsState: BaseInitState(),
      );

  AdsState copyWith({
    GeneralState? getAllFilterAdsState,
    GeneralState? getAllMostRatedAdsState,
    GeneralState? getAllPopularAdsState,
    GeneralState? getAllRecentAdsState,
    GeneralState? getAllSearchAdsState,
    GeneralState? getAdsDetailsState,
    GeneralState? likeAdState,
    GeneralState? disLikeAdState,
    GeneralState? favouriteAdState,
    GeneralState? unFavouriteAdState,
    GeneralState? getAdsShareState,
    GeneralState? getMyFavouriteAdsState,
    GeneralState? getCategoryAdsState,
  }) {
    return AdsState(
      getAllFilterAdsState: getAllFilterAdsState ?? this.getAllFilterAdsState,
      getMyFavouriteAdsState:
          getMyFavouriteAdsState ?? this.getMyFavouriteAdsState,
      getAllMostRatedAdsState:
          getAllMostRatedAdsState ?? this.getAllMostRatedAdsState,
      getAllPopularAdsState:
          getAllPopularAdsState ?? this.getAllPopularAdsState,
      getAllRecentAdsState: getAllRecentAdsState ?? this.getAllRecentAdsState,
      getAllSearchAdsState: getAllSearchAdsState ?? this.getAllSearchAdsState,
      getAdsDetailsState: getAdsDetailsState ?? this.getAdsDetailsState,
      unFavouriteAdState: unFavouriteAdState ?? this.unFavouriteAdState,
      disLikeAdState: disLikeAdState ?? this.disLikeAdState,
      likeAdState: likeAdState ?? this.likeAdState,
      favouriteAdState: favouriteAdState ?? this.favouriteAdState,
      getAdsShareState: getAdsShareState ?? this.getAdsShareState,
      getCategoryAdsState: getCategoryAdsState ?? this.getCategoryAdsState,
    );
  }
}

class GetAllPopularAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetAllPopularAdsSuccessState(this.ads);
}
class GetCategoryAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetCategoryAdsSuccessState(this.ads);
}

class GetAllMyFavouriteAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetAllMyFavouriteAdsSuccessState(this.ads);
}

class GetAllMostRatedAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetAllMostRatedAdsSuccessState(this.ads);
}

class GetAllRecentAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetAllRecentAdsSuccessState(this.ads);
}

class GetAllFilterAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetAllFilterAdsSuccessState(this.ads);
}

class GetSearchFilterAdsSuccessState extends BaseSuccessState {
  final AdsEntity ads;

  GetSearchFilterAdsSuccessState(this.ads);
}

class AdsDetailsSuccessState extends BaseSuccessState {
  final AdsDetailsEntity ads;

  AdsDetailsSuccessState(this.ads);
}

class GetAdsShareSuccessState extends BaseSuccessState {
  final AdsDetailsEntity ads;

  GetAdsShareSuccessState(this.ads);
}

class LikeAdSuccessState extends BaseSuccessState {
  final EmptyEntity ad;

  LikeAdSuccessState(this.ad);
}

class DisLikeAdSuccessState extends BaseSuccessState {
  final EmptyEntity ad;

  DisLikeAdSuccessState(this.ad);
}

class FavouriteAdSuccessState extends BaseSuccessState {
  final EmptyEntity ad;

  FavouriteAdSuccessState(this.ad);
}

class UnFavouriteAdSuccessState extends BaseSuccessState {
  final EmptyEntity ad;

  UnFavouriteAdSuccessState(this.ad);
}
