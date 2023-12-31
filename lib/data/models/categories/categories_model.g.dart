// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    CategoriesModel(
      id: json['id'] as int?,
      parent_id: int.parse(json['parent_id']) ,
      sort_order: int.parse(json['sort_order']) ,
      filter_show: json['filter_show'] as String?,
      slider_show: json['slider_show'] as String?,
      icon: json['icon'],
      head_img: json['head_img'],
      status: json['status'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deleted_at: json['deleted_at'],
      hasChild: int.parse(json['hasChild']) ,
      language_id: int.parse(json['language_id'] ),
      title: json['title'] as String?,
      category_id: int.parse(json['category_id']),
    );

Map<String, dynamic> _$CategoriesModelToJson(CategoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parent_id,
      'sort_order': instance.sort_order,
      'filter_show': instance.filter_show,
      'slider_show': instance.slider_show,
      'icon': instance.icon,
      'head_img': instance.head_img,
      'status': instance.status,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'deleted_at': instance.deleted_at,
      'hasChild': instance.hasChild,
      'category_id': instance.category_id,
      'language_id': instance.language_id,
      'title': instance.title,
    };
