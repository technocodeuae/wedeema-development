import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../core/models/empty_model.dart';
import '../../models/notifications/notifications_model.dart';

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  const NotificationsRemoteDataSourceImpl();

  Future<Result<List<ItemsNotificationsModel>>> getAllNotifications() async {
    return await RemoteDataSource.request<List<ItemsNotificationsModel>>(
          converterList:(list) =>
      list?.map((model) => ItemsNotificationsModel.fromJson(model)).toList() ?? [],      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.allNotifications,
    );
  }

  Future<Result<EmptyModel>> readNotifications(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.readNotification + "/${id}",
    );
  }
  Future<Result<EmptyModel>> removeNotifications(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.removeNotification + "/${id}",
    );
  }
  Future<Result<EmptyModel>> changeNotificationStatus(int active) async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      data: {"active":active},
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.changeNotificationStatus ,
    );
  }
}

abstract class NotificationsRemoteDataSource {
  const NotificationsRemoteDataSource();

  Future<Result<List<ItemsNotificationsModel>>> getAllNotifications();

  Future<Result<EmptyModel>> readNotifications(int id);
  Future<Result<EmptyModel>> removeNotifications(int id);
  Future<Result<EmptyModel>> changeNotificationStatus(int active);
}
