// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsors_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsorsModel _$SponsorsModelFromJson(Map<String, dynamic> json) =>
    SponsorsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String?,
      mobile: json['mobile'] as String?,
      description: json['description'],
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      is_active: int.parse(json['is_active']) ,
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      created_by: json['created_by'],
    );

Map<String, dynamic> _$SponsorsModelToJson(SponsorsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'url': instance.url,
      'mobile': instance.mobile,
      'description': instance.description,
      'created_by': instance.created_by,
      'is_active': instance.is_active,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
