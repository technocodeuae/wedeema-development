import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/notifications_entity.dart';

part 'notifications_model.g.dart';

// @JsonSerializable()
// class NotificationsModel extends BaseModel {
//   final List<ItemsNotificationsModel>? data;
//
//   NotificationsModel({
//     this.data,
//
//   });
//
//   factory NotificationsModel.fromRawJson(String str) =>
//       NotificationsModel.fromJson(json.decode(str));
//
//   factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
//       _$NotificationsModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);
//
//   @override
//   NotificationsEntity toEntity() {
//     return NotificationsEntity(
//       data: data?.map((e) => e.toEntity()).toList(),
//
//     );
//   }
// }


@JsonSerializable()
class ItemsNotificationsModel extends BaseModel {


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

  ItemsNotificationsModel(this.user_id,
      {this.id,
      this.type,
     this.ad_id,
      this.message,
      this.title,
      this.body,
      this.read,
      this.created_at,
      this.updated_at,
      });

  factory ItemsNotificationsModel.fromRawJson(String str) =>
      ItemsNotificationsModel.fromJson(json.decode(str));

  factory ItemsNotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsNotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsNotificationsModelToJson(this);

  @override
  ItemsNotificationsEntity toEntity() {
    return ItemsNotificationsEntity(
      id: this.id,
        read:this.read,
      body: this.body,
      ad_id:this.ad_id,
      user_id:this.user_id,
      message: this.message,
      title: this.title,
      type: this.type,
      created_at: this.created_at,
      updated_at: this.updated_at,

    );
  }
}
