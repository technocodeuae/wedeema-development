import '../../../core/base_repository.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../../core/models/empty_entity.dart';
import '../../data/sources/evaluate/evaluate_remote_data_source.dart';
import 'evaluate_repo_i.dart';

class EvaluateRepo extends BaseRepository implements EvaluateFacade {
  final EvaluateRemoteDataSource _aRD;
  final SharedPrefs _sp;

  EvaluateRepo(
    this._aRD,
    this._sp,
  );



  @override
  Future<Result<EmptyEntity>> evaluateAd(int adId, String? comment, double? value)async {
    final res = await _aRD.evaluateAd(adId,comment,value);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<EmptyEntity>> evaluateUser(int userId, double value) async {
    final res = await _aRD.evaluateUser(userId,value);
    return mapModelToEntity(res);
  }
}
