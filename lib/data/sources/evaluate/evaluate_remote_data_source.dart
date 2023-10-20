import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../core/models/empty_model.dart';
import '../../models/more_info_profile/more_info_profile_model.dart';
import '../../models/other_profile/other_profile_model.dart';
import '../../models/profile/profile_model.dart';

class EvaluateRemoteDataSourceImpl implements EvaluateRemoteDataSource {
  const EvaluateRemoteDataSourceImpl();



  Future<Result<EmptyModel>> evaluateUser(int userId, double value) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"user_evaluator_id":userId,"value":value,"type":"user"},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.evaluate,
    );
  }

  Future<Result<EmptyModel>> evaluateAd(int adId, String? comment, double? value) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"ad_id":adId,"value":value,"comment":comment},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.evaluate,
    );
  }

}

abstract class EvaluateRemoteDataSource {
  const EvaluateRemoteDataSource();


  Future<Result<EmptyModel>> evaluateUser(int userId, double value);
  Future<Result<EmptyModel>> evaluateAd(int userId, String? comment, double? value);

}
