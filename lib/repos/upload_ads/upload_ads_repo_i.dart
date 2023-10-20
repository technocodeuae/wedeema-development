
import 'package:wadeema/data/models/auth/entity/auth_entity.dart';

import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../data/models/ads/entity/ads_entity.dart';
import '../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';

abstract class UploadAdsFacade {

  Future<Result<EmptyEntity>> storeAds(ArgumentPolicy arg);
}
