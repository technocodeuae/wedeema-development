import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/profile/states/profile_state.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/profile/profile_repo_i.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileFacade profileRepo;

  ProfileCubit(
    this.profileRepo,
  ) : super(ProfileState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Future<void> getProfile() async {
    emit(state.copyWith(getProfileState: BaseLoadingState()));
    final result = await profileRepo.getProfile();
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getProfileState: GetProfileSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getProfileState: BaseFailState(
            result.error,
            callback: () => this.getProfile(),
          ),
        ),
      );
    }
  }

  // Future<void> editProfile(Map<String,dynamic> data) async {
  //   emit(state.copyWith(editProfileState: BaseLoadingState()));
  //   final result = await profileRepo.editProfile(data);
  //   if (result.hasDataOnly) {
  //     emit(state.copyWith(
  //         editProfileState: EditProfileSuccessState(result.data!)));
  //   } else {
  //     emit(
  //       state.copyWith(
  //         editProfileState: BaseFailState(
  //           result.error,
  //           callback: () => this.editProfile(data),
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> getMoreInfoProfile() async {
    emit(state.copyWith(getMoreInfoProfileState: BaseLoadingState()));
    final result = await profileRepo.getMoreInfoProfile();
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getMoreInfoProfileState:
              GetMoreInfoProfileSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getMoreInfoProfileState: BaseFailState(
            result.error,
            callback: () => this.getMoreInfoProfile(),
          ),
        ),
      );
    }
  }

  Future<void> getALLBlockers(int page) async {
    emit(state.copyWith(getALLBlockersState: BaseLoadingState()));
    final result = await profileRepo.getALLBlockers(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getALLBlockersState: GetALLBlockersSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getALLBlockersState: BaseFailState(
            result.error,
            callback: () => this.getALLBlockers(page),
          ),
        ),
      );
    }
  }

  Future<void> getALLFollowers(int page) async {
    emit(state.copyWith(getALLFollowersState: BaseLoadingState()));
    final result = await profileRepo.getALLFollowers(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getALLFollowersState: GetALLFollowersSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getALLFollowersState: BaseFailState(
            result.error,
            callback: () => this.getALLFollowers(page),
          ),
        ),
      );
    }
  }

  Future<void> getALLFollowings(int page) async {
    emit(state.copyWith(getALLFollowingsState: BaseLoadingState()));
    final result = await profileRepo.getALLFollowings(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getALLFollowingsState: GetALLFollowingsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getALLFollowingsState: BaseFailState(
            result.error,
            callback: () => this.getALLFollowings(page),
          ),
        ),
      );
    }
  }

  Future<void> getOtherProfile(int userId) async {
    emit(state.copyWith(getOtherProfileState: BaseLoadingState()));
    final result = await profileRepo.getOtherProfile(userId);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getOtherProfileState: GetOtherProfileSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getOtherProfileState: BaseFailState(
            result.error,
            callback: () => this.getOtherProfile(userId),
          ),
        ),
      );
    }
  }

  Future<void> getProfileShare(String url) async {
    emit(state.copyWith(getProfileShareState: BaseLoadingState()));
    final result = await profileRepo.getProfileShare(url);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getProfileShareState: GetProfileShareSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getProfileShareState: BaseFailState(
            result.error,
            callback: () => this.getProfileShare(url),
          ),
        ),
      );
    }
  }

  Future<void> userFollow(int userId) async {
    emit(state.copyWith(followUserState: BaseLoadingState()));
    final result = await profileRepo.userFollow(userId);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          followUserState: FollowUserSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          followUserState: BaseFailState(
            result.error,
            callback: () => this.userFollow(userId),
          ),
        ),
      );
    }
  }

  Future<void> userUnFollow(int userId) async {
    emit(state.copyWith(unfollowUserState: BaseLoadingState()));
    final result = await profileRepo.userUnFollow(userId);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          unfollowUserState: UnFollowUserSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          unfollowUserState: BaseFailState(
            result.error,
            callback: () => this.userUnFollow(userId),
          ),
        ),
      );
    }
  }

  Future<void> userBlock(int userId) async {
    emit(state.copyWith(blockUserState: BaseLoadingState()));
    final result = await profileRepo.userBlock(userId);
    if (result.hasDataOnly) {
      emit(state.copyWith(blockUserState: BlockUserSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          blockUserState: BaseFailState(
            result.error,
            callback: () => this.userBlock(userId),
          ),
        ),
      );
    }
  }

  Future<void> userUnBlock(int userId) async {
    emit(state.copyWith(unBlockUserState: BaseLoadingState()));
    final result = await profileRepo.userUnBlock(userId);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          unBlockUserState: UnBlockUserSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          unBlockUserState: BaseFailState(
            result.error,
            callback: () => this.userUnBlock(userId),
          ),
        ),
      );
    }
  }
}
