
import 'package:wadeema/data/models/auth/entity/auth_entity.dart';

import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../data/models/cities/entity/cities_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';

abstract class CitiesFacade {
  Future<Result<List<CitiesEntity>>> getCities();


}
