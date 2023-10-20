
import 'package:wadeema/data/models/auth/entity/auth_entity.dart';

import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';

abstract class SponsorsFacade {
  Future<Result<List<SponsorsEntity>>> getSponsors();


}
