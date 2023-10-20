import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../../data/models/auth/auth_model.dart';
import '../../models/sponsors/sponsors_model.dart';

class SponsorsRemoteDataSourceImpl implements SponsorsRemoteDataSource {
  const SponsorsRemoteDataSourceImpl();

  Future<Result<List<SponsorsModel>>> getSponsors() async {
    return await RemoteDataSource.request<List<SponsorsModel>>(
      converterList: (list) =>
          list?.map((e) => SponsorsModel.fromJson(e)).toList() ?? [],
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.sponsors,
    );
  }
}

abstract class SponsorsRemoteDataSource {
  const SponsorsRemoteDataSource();

  Future<Result<List<SponsorsModel>>> getSponsors();
}
