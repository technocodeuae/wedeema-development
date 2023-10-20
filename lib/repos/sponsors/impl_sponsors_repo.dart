
import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import 'sponsors_repo_i.dart';

class SponsorsRepo extends BaseRepository implements SponsorsFacade {
  final SponsorsRemoteDataSource _aRD;
  final SharedPrefs _sp;

  SponsorsRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<List<SponsorsEntity>>> getSponsors() async {
    final res = await _aRD.getSponsors();
    return mapModelsToEntities(res);
  }


}
