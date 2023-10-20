
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/auth/entity/auth_entity.dart';
import '../../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../../data/models/profile/entity/profile_entity.dart';

class UpdateProfileState {

  GeneralState editProfileState;

  UpdateProfileState({
    required this.editProfileState,

  });

  factory UpdateProfileState.initialState() => UpdateProfileState(


    editProfileState: BaseInitState(),

  );

  UpdateProfileState copyWith({

    GeneralState? editProfileState,


  }) {
    return UpdateProfileState(

      editProfileState: editProfileState ?? this.editProfileState,


    );
  }
}



class EditProfileSuccessState extends BaseSuccessState {
  final ItemsUserEntity user;

  EditProfileSuccessState(this.user);
}

