// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsNotificationsModel _$ItemsNotificationsModelFromJson(
        Map<String, dynamic> json) =>
    ItemsNotificationsModel(
      int.parse(json['user_id']??'0'),
      id: json['id'] as int?,
      type: json['type'] as String?,
      ad_id: (json['ad_id']??'0'),
      message: json['message'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      read: int.parse(json['read']??'0') ,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ItemsNotificationsModelToJson(
        ItemsNotificationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'ad_id': instance.ad_id,
      'title': instance.title,
      'type': instance.type,
      'message': instance.message,
      'body': instance.body,
      'read': instance.read,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
