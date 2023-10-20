// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
