
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';

class SponsorsState {

  GeneralState getSponsorsState;


  SponsorsState({
    required this.getSponsorsState,
  });

  factory SponsorsState.initialState() => SponsorsState(

    getSponsorsState: BaseInitState(),

  );

  SponsorsState copyWith({

    GeneralState? getSponsorsState,

  }) {
    return SponsorsState(

      getSponsorsState: getSponsorsState ?? this.getSponsorsState,

    );
  }
}


class SponsorsSuccessState extends BaseSuccessState {
  final List<SponsorsEntity> sponsor;

  SponsorsSuccessState(this.sponsor);
}