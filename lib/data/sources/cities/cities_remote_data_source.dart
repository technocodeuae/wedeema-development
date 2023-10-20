import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../../data/models/auth/auth_model.dart';
import '../../models/cities/cities_model.dart';
import '../../models/sponsors/sponsors_model.dart';

class CitiesRemoteDataSourceImpl implements CitiesRemoteDataSource {
  const CitiesRemoteDataSourceImpl();

  Future<Result<List<CitiesModel>>> getCities() async {
    return await RemoteDataSource.request<List<CitiesModel>>(
      converterList: (list) =>
          list?.map((e) => CitiesModel.fromJson(e)).toList() ?? [],
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.cities,
    );
  }
}

abstract class CitiesRemoteDataSource {
  const CitiesRemoteDataSource();

  Future<Result<List<CitiesModel>>> getCities();
}
