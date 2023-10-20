
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../data/models/cities/entity/cities_entity.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';

class CitiesState {

  GeneralState getCitiesState;


  CitiesState({
    required this.getCitiesState,
  });

  factory CitiesState.initialState() => CitiesState(

    getCitiesState: BaseInitState(),

  );

  CitiesState copyWith({

    GeneralState? getCitiesState,

  }) {
    return CitiesState(

      getCitiesState: getCitiesState ?? this.getCitiesState,

    );
  }
}


class CitiesSuccessState extends BaseSuccessState {
  final List<CitiesEntity> cities;

  CitiesSuccessState(this.cities);
}