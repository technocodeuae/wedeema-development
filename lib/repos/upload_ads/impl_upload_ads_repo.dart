
import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/ads/entity/ads_entity.dart';
import '../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../data/sources/ads/ads_remote_data_source.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import '../../data/sources/upload_ads/ads_remote_data_source.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';
import 'upload_ads_repo_i.dart';

class UploadAdsRepo extends BaseRepository implements UploadAdsFacade {
  final UploadAdsRemoteDataSource _aRD;
  final SharedPrefs _sp;

  UploadAdsRepo(
    this._aRD,
    this._sp,
  );


  @override
  Future<Result<EmptyEntity>> storeAds(ArgumentPolicy arg) async {
    final res = await _aRD.storeAds(arg);
    return mapModelToEntity(res);
  }


}
