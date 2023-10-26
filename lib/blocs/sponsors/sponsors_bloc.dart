import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/sponsors/states/sponsors_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/sponsors/sponsors_repo_i.dart';

class SponsorsCubit extends Cubit<SponsorsState> {
  final SponsorsFacade sponsorsRepo;

  SponsorsCubit(
    this.sponsorsRepo,
  ) : super(SponsorsState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Future<void> getSponsors() async {
    emit(state.copyWith(getSponsorsState: BaseLoadingState()));
    final result = await sponsorsRepo.getSponsors(
    );
    if (result.hasDataOnly) {

      emit(state.copyWith(getSponsorsState: SponsorsSuccessState(result.data!)));

    } else {
      emit(
        state.copyWith(
          getSponsorsState: BaseFailState(
            result.error,
            callback: () => this.getSponsors(

            ),
          ),
        ),
      );
    }
  }
}
