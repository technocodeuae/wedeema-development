import '../../../core/results/result.dart';
import '../../core/models/empty_entity.dart';
import '../../data/models/notifications/entity/notifications_entity.dart';

abstract class NotificationsFacade {
  Future<Result<List<ItemsNotificationsEntity>>> getAllNotifications();

  Future<Result<EmptyEntity>> readNotifications(int id);
  Future<Result<EmptyEntity>> removeNotifications(int id);
  Future<Result<EmptyEntity>> changeNotificationStatus(int active);
}
