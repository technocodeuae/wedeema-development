// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListUserModel _$ListUserModelFromJson(Map<String, dynamic> json) =>
    ListUserModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemsUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListUserModelToJson(ListUserModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
