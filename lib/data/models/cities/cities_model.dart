import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/cities_entity.dart';

part 'cities_model.g.dart';

@JsonSerializable()
class CitiesModel extends BaseModel {
  final int? id;
  final String? title;
  final String? status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final DateTime? deleted_at;

  CitiesModel({
    this.id,
    this.title,
    this.status,
    this.deleted_at,
    this.updated_at,
    this.created_at,
  });

  factory CitiesModel.fromRawJson(String str) =>
     CitiesModel.fromJson(json.decode(str));

  factory CitiesModel.fromJson(Map<String, dynamic> json) =>
      _$CitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CitiesModelToJson(this);

  @override
 CitiesEntity toEntity() {
    return CitiesEntity(
      id:id,
      title:title,
      deleted_at: deleted_at,
      status: status,
      created_at:created_at,
      updated_at:updated_at,
    );
  }
}




