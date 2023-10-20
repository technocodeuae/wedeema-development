import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/cities/states/cities_state.dart';
import 'package:wadeema/blocs/sponsors/states/sponsors_state.dart';

import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_success_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../core/errors/unauthorized_error.dart';
import '../../repos/auth/auth_repo_i.dart';
import '../../repos/cities/cities_repo_i.dart';


class CitiesCubit extends Cubit<CitiesState> {
  final CitiesFacade citiesRepo;

  CitiesCubit(
    this.citiesRepo,
  ) : super(CitiesState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Future<void> getCities() async {
    emit(state.copyWith(getCitiesState: BaseLoadingState()));
    final result = await citiesRepo.getCities(
    );
    if (result.hasDataOnly) {

      emit(state.copyWith(getCitiesState: CitiesSuccessState(result.data!)));

    } else {
      emit(
        state.copyWith(
          getCitiesState: BaseFailState(
            result.error,
            callback: () => this.getCities(

            ),
          ),
        ),
      );
    }
  }
}
