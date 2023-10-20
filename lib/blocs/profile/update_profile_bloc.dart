import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/profile/states/profile_state.dart';
import 'package:wadeema/blocs/profile/states/update_profile_state.dart';

import '../../../core/bloc/states/base_fail_state.dart';
import '../../../core/bloc/states/base_wait_state.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/profile/profile_repo_i.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileFacade profileRepo;

  UpdateProfileCubit(
    this.profileRepo,
  ) : super(UpdateProfileState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }


  Future<void> editProfile(Map<String,dynamic> data) async {
    emit(state.copyWith(editProfileState: BaseLoadingState()));
    final result = await profileRepo.editProfile(data);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          editProfileState: EditProfileSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          editProfileState: BaseFailState(
            result.error,
            callback: () => this.editProfile(data),
          ),
        ),
      );
    }
  }



}
