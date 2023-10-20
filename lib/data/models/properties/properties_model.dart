import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/properties_entity.dart';

part 'properties_model.g.dart';

@JsonSerializable()
class PropertiesModel extends BaseModel {
  final ItemsPropertiesModel? property;
  final List<ItemsSubPropertiesModel>? sub_properties;

  PropertiesModel({
    this.property,
    this.sub_properties,
  });

  factory PropertiesModel.fromRawJson(String str) =>
      PropertiesModel.fromJson(json.decode(str));

  factory PropertiesModel.fromJson(Map<String, dynamic> json) =>
      _$PropertiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesModelToJson(this);

  @override
  PropertiesEntity toEntity() {
    return PropertiesEntity(
      sub_properties: sub_properties?.map((e) => e.toEntity()).toList(),
      property: property?.toEntity(),
    );
  }
}

@JsonSerializable()
class ItemsPropertiesModel extends BaseModel {
  final int? id;
  final String? status;
  final dynamic parentId;
  final int? sortOrder;
  final int? hasChild;
  final String? essential;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? categoryId;
  final int? propertyId;
  final int? languageId;
  final String? title;
  final String? type;

  ItemsPropertiesModel({
    this.id,
    this.categoryId,
    this.hasChild,
    this.title,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.parentId,
    this.status,
    this.languageId,
    this.deletedAt,
    this.sortOrder,
    this.essential,
    this.propertyId,
  });

  factory ItemsPropertiesModel.fromRawJson(String str) =>
      ItemsPropertiesModel.fromJson(json.decode(str));

  factory ItemsPropertiesModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsPropertiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsPropertiesModelToJson(this);

  @override
  ItemsPropertiesEntity toEntity() {
    return ItemsPropertiesEntity(
      id: this.id,
      status: this.status,
      categoryId: this.categoryId,
      title: this.title,
      type: this.type,
      createdAt: this.createdAt,
      deletedAt: this.deletedAt,
      essential: this.essential,
      hasChild: this.hasChild,
      languageId: this.languageId,
      parentId: this.propertyId,
      propertyId: this.propertyId,
      sortOrder: this.sortOrder,
      updatedAt: this.updatedAt,
    );
  }
}


@JsonSerializable()
class ItemsSubPropertiesModel extends BaseModel {
  final int? id;
  final int? propertyId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? subpropertyId;
  final int? languageId;
  final String? title;
  final String? type;

  ItemsSubPropertiesModel({
    this.id,
    this.title,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.status,
    this.languageId,
    this.deletedAt,
    this.subpropertyId,
    this.propertyId,
  });

  factory ItemsSubPropertiesModel.fromRawJson(String str) =>
      ItemsSubPropertiesModel.fromJson(json.decode(str));

  factory ItemsSubPropertiesModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsSubPropertiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsSubPropertiesModelToJson(this);

  @override
  ItemsSubPropertiesEntity toEntity() {
    return ItemsSubPropertiesEntity(
      id: this.id,
      status: this.status,
      title: this.title,
      createdAt: this.createdAt,
      deletedAt: this.deletedAt,
      languageId: this.languageId,
      propertyId: this.propertyId,
      updatedAt: this.updatedAt,
      subpropertyId: this.subpropertyId,
    );
  }
}