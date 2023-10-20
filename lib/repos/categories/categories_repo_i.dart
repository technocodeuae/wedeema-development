
import 'package:wadeema/data/models/auth/entity/auth_entity.dart';
import 'package:wadeema/data/models/properties/entity/properties_entity.dart';

import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../data/models/categories/entity/categories_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';

abstract class CategoriesFacade {
  Future<Result<List<CategoriesEntity>>> getMainCategories();
  Future<Result<List<CategoriesEntity>>> getSubCategories(int id);
  Future<Result<List<PropertiesEntity>>> getPropertiesCategories(int id);
}
