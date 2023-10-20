import '../../../../core/models/base_entity.dart';

// class NotificationsEntity extends BaseEntity {
//   final List<ItemsNotificationsEntity>? data;
//
//   NotificationsEntity({
//
//     this.data,
//   });
//
//   @override
//   List<Object?> get props => [
//     this.data,
//
//   ];
//
//
// }

class ItemsNotificationsEntity extends BaseEntity {
  ItemsNotificationsEntity({
    this.id,
    this.title,
    this.created_at,
    this.updated_at,
    this.type,
    this.message,
    this.body,
    this.read,
    this.user_id,
    this.ad_id,
  });

  final int? id;
  final int? user_id;
  final int? ad_id;
  final String? title;
  final String? type;
  final String? message;
  final String? body;
  int? read;
  final DateTime? created_at;
  final DateTime? updated_at;

  @override
  List<Object?> get props => [
        this.id,
        this.read,
        this.body,
        this.message,
        this.title,
        this.type,
        this.created_at,
        this.updated_at,
        this.ad_id,
        this.user_id,
      ];
}
