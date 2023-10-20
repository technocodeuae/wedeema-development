import '../../../core/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../../data/models/cities/entity/cities_entity.dart';
import '../../data/sources/cities/cities_remote_data_source.dart';
import 'cities_repo_i.dart';

class CitiesRepo extends BaseRepository implements CitiesFacade {
  final CitiesRemoteDataSource _aRD;
  final SharedPrefs _sp;

  CitiesRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<List<CitiesEntity>>> getCities() async {
    final res = await _aRD.getCities();
    return mapModelsToEntities(res);
  }
}
