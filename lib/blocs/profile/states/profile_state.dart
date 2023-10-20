
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/auth/entity/auth_entity.dart';
import '../../../data/models/list_user/entity/list_user_entity.dart';
import '../../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../../data/models/profile/entity/profile_entity.dart';

class ProfileState {

  GeneralState getProfileState;
  GeneralState getMoreInfoProfileState;
  GeneralState getOtherProfileState;
  GeneralState getProfileShareState;
  GeneralState followUserState;
  GeneralState unfollowUserState;
  GeneralState blockUserState;
  GeneralState unBlockUserState;
  GeneralState getALLFollowersState;
  GeneralState getALLFollowingsState;
  GeneralState getALLBlockersState;



  ProfileState({
    required this.getMoreInfoProfileState,
    required this.getProfileState,
    required this.blockUserState,
    required this.followUserState,
    required this.getOtherProfileState,
    required this.unBlockUserState,
    required this.unfollowUserState,
    required this.getProfileShareState,
    required this.getALLBlockersState,
    required this.getALLFollowersState,
    required this.getALLFollowingsState,
  });

  factory ProfileState.initialState() => ProfileState(

    getProfileState: BaseInitState(),
    getMoreInfoProfileState: BaseInitState(),
    unfollowUserState: BaseInitState(),
    unBlockUserState: BaseInitState(),
    getOtherProfileState: BaseInitState(),
    followUserState: BaseInitState(),
    blockUserState: BaseInitState(),
    getProfileShareState: BaseInitState(),
    getALLFollowingsState: BaseInitState(),
    getALLFollowersState: BaseInitState(),
    getALLBlockersState: BaseInitState(),


  );

  ProfileState copyWith({

    GeneralState? getProfileState,
    GeneralState? getMoreInfoProfileState,
    GeneralState? getOtherProfileState,
    GeneralState? followUserState,
    GeneralState? unfollowUserState,
    GeneralState? blockUserState,
    GeneralState? unBlockUserState,
    GeneralState? getProfileShareState,
    GeneralState? getALLFollowersState,
    GeneralState? getALLFollowingsState,
    GeneralState? getALLBlockersState,

  }) {
    return ProfileState(

      getMoreInfoProfileState: getMoreInfoProfileState ?? this.getMoreInfoProfileState,
      getProfileShareState: getProfileShareState ?? this.getProfileShareState,
      getProfileState: getProfileState ?? this.getProfileState,
      getOtherProfileState: getOtherProfileState ?? this.getOtherProfileState,
      blockUserState: blockUserState ?? this.blockUserState,
      followUserState: followUserState ?? this.followUserState,
      unBlockUserState:  unBlockUserState ?? this.unBlockUserState,
      unfollowUserState: unBlockUserState ?? this.unfollowUserState,
      getALLBlockersState: getALLBlockersState ?? this.getALLBlockersState,
      getALLFollowersState: getALLFollowersState ?? this.getALLFollowersState,
      getALLFollowingsState: getALLFollowingsState ?? this.getALLFollowingsState,


    );
  }
}



class GetProfileSuccessState extends BaseSuccessState {
  final ProfileEntity profile;

  GetProfileSuccessState(this.profile);
}



class GetMoreInfoProfileSuccessState extends BaseSuccessState {
  final MoreInfoProfileEntity profile;

  GetMoreInfoProfileSuccessState(this.profile);
}

class GetALLFollowingsSuccessState extends BaseSuccessState {
  final ListUserEntity users;

  GetALLFollowingsSuccessState(this.users);
}

class GetALLBlockersSuccessState extends BaseSuccessState {
  final ListUserEntity users;

  GetALLBlockersSuccessState(this.users);
}

class GetALLFollowersSuccessState extends BaseSuccessState {
  final ListUserEntity users;

  GetALLFollowersSuccessState(this.users);
}




class GetOtherProfileSuccessState extends BaseSuccessState {
  final OtherProfileEntity profile;

  GetOtherProfileSuccessState(this.profile);
}

class GetProfileShareSuccessState extends BaseSuccessState {
  final OtherProfileEntity profile;

  GetProfileShareSuccessState(this.profile);
}

class FollowUserSuccessState extends BaseSuccessState {
  final EmptyEntity user;

  FollowUserSuccessState(this.user);
}

class UnFollowUserSuccessState extends BaseSuccessState {
  final EmptyEntity user;

  UnFollowUserSuccessState(this.user);
}
class BlockUserSuccessState extends BaseSuccessState {
  final EmptyEntity user;

  BlockUserSuccessState(this.user);
}
class UnBlockUserSuccessState extends BaseSuccessState {
  final EmptyEntity user;

  UnBlockUserSuccessState(this.user);
}


