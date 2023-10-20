import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/ads/states/ads_state.dart';
import 'package:wadeema/blocs/sponsors/states/sponsors_state.dart';
import 'package:wadeema/blocs/upload_ads/states/upload_ads_state.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_success_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/ads/ads_repo_i.dart';
import '../../repos/sponsors/sponsors_repo_i.dart';
import '../../repos/upload_ads/upload_ads_repo_i.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';

class UploadAdsCubit extends Cubit<UploadAdsState> {
  final UploadAdsFacade adsRepo;

  UploadAdsCubit(
    this.adsRepo,
  ) : super(UploadAdsState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }





  Future<void> storeAds(ArgumentPolicy arg) async {
    emit(state.copyWith(storeAdsState: BaseLoadingState()));
    final result = await adsRepo.storeAds(arg);
    if (result.hasDataOnly) {
      emit(state.copyWith(storeAdsState: StoreAdsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          storeAdsState: BaseFailState(
            result.error,
            callback: () => this.storeAds(arg),
          ),
        ),
      );
    }
  }
}
