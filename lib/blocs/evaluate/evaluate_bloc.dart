import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/evaluate/states/evaluate_state.dart';
import 'package:wadeema/blocs/profile/states/profile_state.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/evaluate/evaluate_repo_i.dart';
import '../../repos/profile/profile_repo_i.dart';

class EvaluateCubit extends Cubit<EvaluateState> {
  final EvaluateFacade evaluateRepo;

  EvaluateCubit(
    this.evaluateRepo,
  ) : super(EvaluateState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }



  Future<void>  evaluateUser(int userId, double value) async {
    emit(state.copyWith(evaluateUserState: BaseLoadingState()));
    final result = await evaluateRepo.evaluateUser(userId,value);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          evaluateUserState:
          EvaluateUserSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          evaluateUserState: BaseFailState(
            result.error,
            callback: () => this.evaluateUser(userId,value),
          ),
        ),
      );
    }
  }
  Future<void> evaluateAd(int adId, String? comment, double? value) async {
    emit(state.copyWith(evaluateAdsState: BaseLoadingState()));
    final result = await evaluateRepo.evaluateAd(adId,comment,value);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          evaluateAdsState:
          EvaluateAdSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          evaluateAdsState: BaseFailState(
            result.error,
            callback: () => this.evaluateAd(adId,comment,value),
          ),
        ),
      );
    }
  }

}
