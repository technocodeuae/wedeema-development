// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseModel<T> _$ApiResponseModelFromJson<T extends BaseModel>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponseModel<T>(
      json['status'] as bool?,
      json['error'] == null
          ? null
          : ApiErrorModel.fromJson(json['error'] as Map<String, dynamic>),
      _$nullableGenericFromJson(json['result'], fromJsonT),
    );

Map<String, dynamic> _$ApiResponseModelToJson<T extends BaseModel>(
  ApiResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'result': _$nullableGenericToJson(instance.result, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
