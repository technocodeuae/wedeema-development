import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/sponsors_entity.dart';

part 'sponsors_model.g.dart';

@JsonSerializable()
class SponsorsModel extends BaseModel {
  final int? id;
  final String? name;
  final String? image;
  final String? url;
  final String? mobile;
  final dynamic description;
  final dynamic created_by;
  final int? is_active;
  final DateTime? created_at;
  final DateTime? updated_at;

  SponsorsModel({
    this.id,
    this.name,
    this.image,
    this.url,
    this.mobile,
    this.description,
    this.created_at,
    this.is_active,
    this.updated_at,
    this.created_by,
  });

  factory SponsorsModel.fromRawJson(String str) =>
      SponsorsModel.fromJson(json.decode(str));

  factory SponsorsModel.fromJson(Map<String, dynamic> json) =>
      _$SponsorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorsModelToJson(this);

  @override
  SponsorsEntity toEntity() {
    return SponsorsEntity(
      id:id,
      name:name,
      image:image,
      url:url,
      mobile:mobile,
      description:description,
      created_by:created_by,
      is_active:is_active,
      created_at:created_at,
      updated_at:updated_at,
    );
  }
}




