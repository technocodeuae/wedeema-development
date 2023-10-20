import '../../../core/results/result.dart';
import '../../core/models/empty_entity.dart';
import '../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../data/models/more_info_profile/more_info_profile_model.dart';
import '../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../data/models/profile/entity/profile_entity.dart';
import '../../data/models/profile/profile_model.dart';

abstract class EvaluateFacade {

  Future<Result<EmptyEntity>> evaluateAd(int adId, String? comment, double? value);
  Future<Result<EmptyEntity>> evaluateUser(int userId, double value);
}
