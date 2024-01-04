import '../../../core/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../../core/models/empty_entity.dart';
import '../../data/models/list_user/entity/list_user_entity.dart';
import '../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../data/models/more_info_profile/more_info_profile_model.dart';
import '../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../data/models/profile/entity/profile_entity.dart';
import '../../data/models/profile/profile_model.dart';
import '../../data/sources/profile/profile_remote_data_source.dart';
import 'profile_repo_i.dart';

class ProfileRepo extends BaseRepository implements ProfileFacade {
  final ProfileRemoteDataSource _aRD;
  final SharedPrefs _sp;

  ProfileRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<ProfileEntity>> getProfile() async {
    final res = await _aRD.getProfile();
    return mapModelToEntity(res);
  }


  @override
  Future<Result<ItemsUserEntity>> editProfile(Map<String,dynamic> data) async {
    final res = await _aRD.editProfile(data);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<MoreInfoProfileEntity>> getMoreInfoProfile() async {
    final res = await _aRD.getMoreInfoProfile();
    return mapModelToEntity(res);
  }

  @override
  Future<Result<OtherProfileEntity>> getOtherProfile(int userId)async {
    final res = await _aRD.getOtherProfile(userId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<OtherProfileEntity>> getProfileShare(String url)async {
    final res = await _aRD.getProfileShare(url);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> userFollow(int userId)async {
    final res = await _aRD.userFollow(userId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> userUnFollow(int userId)async {
    final res = await _aRD.userUnFollow(userId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> userBlock(int userId)async {
    final res = await _aRD.userBlock(userId);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ListUserEntity>> getALLFollowings(int page)async {
    final res = await _aRD.getALLFollowings(page);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ListUserEntity>> getALLFollowers(int page)async {
    final res = await _aRD.getALLFollowers(page);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ListUserEntity>> getALLBlockers(int page)async {
    final res = await _aRD.getALLBlockers(page);
    return mapModelToEntity(res);
  }


  @override
  Future<Result<ListUserEntity>> getOtherFollowings(int userId,int page)async {
    final res = await _aRD.getOtherFollowings(userId, page);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ListUserEntity>> getOtherFollowers(int userId,int page)async {
    final res = await _aRD.getOtherFollowers(userId, page);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ListUserEntity>> getOtherBlockers(int userId,int page)async {
    final res = await _aRD.getOtherBlockers(userId, page);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> userUnBlock(int userId)async {
    final res = await _aRD.userUnBlock(userId);
    return mapModelToEntity(res);
  }
}
