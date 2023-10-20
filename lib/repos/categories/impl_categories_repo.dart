
import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/models/categories/entity/categories_entity.dart';
import '../../data/models/properties/entity/properties_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import '../../data/sources/categories/categories_remote_data_source.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import 'categories_repo_i.dart';

class CategoriesRepo extends BaseRepository implements CategoriesFacade {
  final CategoriesRemoteDataSource _aRD;
  final SharedPrefs _sp;

  CategoriesRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<List<CategoriesEntity>>> getMainCategories() async {
    final res = await _aRD.getMainCategories();
    return mapModelsToEntities(res);
  }

  @override
  Future<Result<List<CategoriesEntity>>> getSubCategories(int id) async {
    final res = await _aRD.getSubCategories(id);
    return mapModelsToEntities(res);
  }

  @override
  Future<Result<List<PropertiesEntity>>> getPropertiesCategories(int id) async {
    final res = await _aRD.getPropertiesCategories(id);
    return mapModelsToEntities(res);
  }

}
