import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';

class EvaluateState {
  GeneralState evaluateUserState;
  GeneralState evaluateAdsState;

  EvaluateState({
    required this.evaluateAdsState,
    required this.evaluateUserState,
  });

  factory EvaluateState.initialState() => EvaluateState(
        evaluateAdsState: BaseInitState(),
        evaluateUserState: BaseInitState(),
      );

  EvaluateState copyWith({
    GeneralState? evaluateUserState,
    GeneralState? evaluateAdsState,
  }) {
    return EvaluateState(
      evaluateAdsState: evaluateAdsState ?? this.evaluateAdsState,
      evaluateUserState: evaluateUserState ?? this.evaluateUserState,
    );
  }
}

class EvaluateUserSuccessState extends BaseSuccessState {
  final EmptyEntity user;

  EvaluateUserSuccessState(this.user);
}

class EvaluateAdSuccessState extends BaseSuccessState {
  final EmptyEntity ad;

  EvaluateAdSuccessState(this.ad);
}
