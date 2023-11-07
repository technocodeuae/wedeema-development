// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_model_firebase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesAllDataFirebaseModel _$MessagesAllDataFirebaseModelFromJson(
        Map<String, dynamic> json) =>
    MessagesAllDataFirebaseModel(
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessagesModelFirebase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesAllDataFirebaseModelToJson(
        MessagesAllDataFirebaseModel instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };

MessagesModelFirebase _$MessagesModelFirebaseFromJson(Map<String, dynamic> json) =>
    MessagesModelFirebase(
      id: json['id'] as int?,
      ad_id: json['ad_id'],
      ad_created_at: json['ad_created_at'] == null
          ? null
          : DateTime.parse(json['ad_created_at'] as String),
      message: json['message'] as String?,
      channel: json['channel'] as int?,
      user_name_2: json['user_name_2'],
      user_name_1: json['user_name'] as String?,
      user_id_2: json['user_id_2'],
      user_id_1: json['user_id_1'],
      ad_name: json['ad_name'] as String?,
      ad_img: json['ad_img'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      profile_pic: json['profile_pic'] as String?,
      type: json['type'] as String?,
      filename: json['filename'] as String?,
      filepath: json['filepath'] as String?,
    );

Map<String, dynamic> _$MessagesModelFirebaseToJson(MessagesModelFirebase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id_1': instance.user_id_1,
      'user_id_2': instance.user_id_2,
      'ad_id': instance.ad_id,
      'message': instance.message,
      'type': instance.type,
      'filename': instance.filename,
      'filepath': instance.filepath,
      'channel': instance.channel,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'user_name_1': instance.user_name_1,
      'user_name_2': instance.user_name_2,
      'ad_name': instance.ad_name,
      'ad_img': instance.ad_img,
      'ad_created_at': instance.ad_created_at?.toIso8601String(),
      'profile_pic': instance.profile_pic,
    };
