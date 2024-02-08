import '../../../core/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../../core/models/empty_entity.dart';
import '../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../data/models/more_info_profile/more_info_profile_model.dart';
import '../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../data/models/profile/entity/profile_entity.dart';
import '../../data/models/profile/profile_model.dart';
import '../../data/models/settings/entity/settings_entity.dart';
import '../../data/models/share_link/entity/share_link_entity.dart';
import '../../data/sources/profile/profile_remote_data_source.dart';
import '../../data/sources/settings/settings_remote_data_source.dart';
import 'settings_repo_i.dart';

class SettingsRepo extends BaseRepository implements SettingsFacade {
  final SettingsRemoteDataSource _aRD;
  final SharedPrefs _sp;

  SettingsRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<ShareLinkEntity>> getShareLink(String url) async {
    final res = await _aRD.getShareLink(url);
    print("Share ==> ${res.data} ,,error : ${res.error} ,, MAp : ${mapModelToEntity(res)}");
    return mapModelToEntity(res);
  }


  @override
  Future<Result<ItemsSettingsEntity>> getAboutApp() async {
    final res = await _aRD.getAboutApp();
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ItemsSettingsEntity>> getPrivacyPolicy() async {
    final res = await _aRD.getPrivacyPolicy();
    return mapModelToEntity(res);
  }

  @override
  Future<Result<ItemsSettingsEntity>> getTerms() async {
    final res = await _aRD.getTerms();
    return mapModelToEntity(res);
  }

  @override
  Future<Result<FAQEntity>> getFAQ(int page) async {
    final res = await _aRD.getFAQ(page);
    return mapModelToEntity(res);
  }




}
