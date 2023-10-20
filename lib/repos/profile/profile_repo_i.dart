import 'package:wadeema/data/models/list_user/entity/list_user_entity.dart';

import '../../../core/results/result.dart';
import '../../core/models/empty_entity.dart';
import '../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../data/models/more_info_profile/more_info_profile_model.dart';
import '../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../data/models/profile/entity/profile_entity.dart';
import '../../data/models/profile/profile_model.dart';

abstract class ProfileFacade {
  Future<Result<ProfileEntity>> getProfile();
  Future<Result<ItemsUserEntity>> editProfile(Map<String,dynamic> data);
  Future<Result<MoreInfoProfileEntity>> getMoreInfoProfile();

  Future<Result<OtherProfileEntity>> getOtherProfile(int userId);
  Future<Result<OtherProfileEntity>> getProfileShare(String url );
  Future<Result<EmptyEntity>> userFollow(int userId);
  Future<Result<EmptyEntity>> userUnFollow(int userId);
  Future<Result<EmptyEntity>> userBlock(int userId);
  Future<Result<EmptyEntity>> userUnBlock(int userId);

  Future<Result<ListUserEntity>> getALLFollowings(int page);
  Future<Result<ListUserEntity>> getALLFollowers(int page);
  Future<Result<ListUserEntity>> getALLBlockers(int page);
}
