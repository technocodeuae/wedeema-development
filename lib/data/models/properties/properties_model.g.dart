// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertiesModel _$PropertiesModelFromJson(Map<String, dynamic> json) =>
    PropertiesModel(
      property: json['property'] == null
          ? null
          : ItemsPropertiesModel.fromJson(
              json['property'] as Map<String, dynamic>),
      sub_properties: (json['sub_properties'] as List<dynamic>?)
          ?.map((e) =>
              ItemsSubPropertiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertiesModelToJson(PropertiesModel instance) =>
    <String, dynamic>{
      'property': instance.property,
      'sub_properties': instance.sub_properties,
    };

ItemsPropertiesModel _$ItemsPropertiesModelFromJson(
        Map<String, dynamic> json) =>
    ItemsPropertiesModel(
      id: json['id'] as int?,
      categoryId: json['categoryId'] as int?,
      hasChild: int.parse(json['hasChild'] ??'0') ,
      title: json['title'] as String?,
      type: json['type'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      parentId: json['parentId'],
      status: json['status'] as String?,
      languageId: json['languageId'] as int?,
      deletedAt: json['deletedAt'],
      sortOrder: json['sortOrder'] as int?,
      essential: json['essential'] as String?,
      propertyId: int.parse(json['property_id']  ??'0'),
    );

Map<String, dynamic> _$ItemsPropertiesModelToJson(
        ItemsPropertiesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'parentId': instance.parentId,
      'sortOrder': instance.sortOrder,
      'hasChild': instance.hasChild,
      'essential': instance.essential,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'categoryId': instance.categoryId,
      'propertyId': instance.propertyId,
      'languageId': instance.languageId,
      'title': instance.title,
    };

ItemsSubPropertiesModel _$ItemsSubPropertiesModelFromJson(
        Map<String, dynamic> json) =>
    ItemsSubPropertiesModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String?,
      languageId: json['languageId'] as int?,
      deletedAt: json['deletedAt'],
      subpropertyId: json['subpropertyId'] as int?,
      propertyId: json['propertyId'] as int?,
    );

Map<String, dynamic> _$ItemsSubPropertiesModelToJson(
        ItemsSubPropertiesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'subpropertyId': instance.subpropertyId,
      'languageId': instance.languageId,
      'title': instance.title,
    };
