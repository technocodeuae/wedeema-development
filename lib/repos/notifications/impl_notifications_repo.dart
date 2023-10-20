import '../../../core/results/result.dart';
import '../../core/base_repository.dart';
import '../../core/models/empty_entity.dart';
import '../../core/shared_prefs/shared_prefs.dart';
import '../../data/models/notifications/entity/notifications_entity.dart';
import '../../data/sources/notifications/notifications_remote_data_source.dart';
import 'notifications_repo_i.dart';

class NotificationsRepo extends BaseRepository implements NotificationsFacade {
  final NotificationsRemoteDataSource _aRD;
  final SharedPrefs _sp;

  NotificationsRepo(
    this._aRD,
    this._sp,
  );

  @override
  Future<Result<List<ItemsNotificationsEntity>>> getAllNotifications() async{
    final res = await _aRD.getAllNotifications();
    return mapModelsToEntities(res);
  }

  @override
  Future<Result<EmptyEntity>> readNotifications(int id) async {
    final res = await _aRD.readNotifications(id);
    return mapModelToEntity(res);
  }
  @override
  Future<Result<EmptyEntity>> removeNotifications(int id) async {
    final res = await _aRD.removeNotifications(id);
    return mapModelToEntity(res);
  }
  @override
  Future<Result<EmptyEntity>> changeNotificationStatus(int active) async {
    final res = await _aRD.changeNotificationStatus(active);
    return mapModelToEntity(res);
  }


}
