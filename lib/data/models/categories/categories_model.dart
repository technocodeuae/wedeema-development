import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/categories_entity.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel extends BaseModel {
  final int? id;
  final int? parent_id;
  final int? sort_order;
  final String? filter_show;
  final String? slider_show;
  final dynamic icon;
  final dynamic head_img;
  final String? status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final int? hasChild;
  final int? category_id;
  final int? language_id;
  final String? title;


  CategoriesModel({
    this.id,
    this.parent_id,
    this.sort_order,
    this.filter_show,
    this.slider_show,
    this.icon,
    this.head_img,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.hasChild,
    this.language_id,
    this.title,
    this.category_id,
  });

  factory CategoriesModel.fromRawJson(String str) =>
      CategoriesModel.fromJson(json.decode(str));

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);

  @override
  CategoriesEntity toEntity() {
    return CategoriesEntity(
        id:this.id,
      parent_id:this.parent_id,
      sort_order:this.sort_order,
      filter_show:this.filter_show,
      slider_show:this.slider_show,
      icon:this.icon,
      head_img:this.head_img,
      status:this.status,
      created_at:this.created_at,
      updated_at:this.updated_at,
      deleted_at:this.deleted_at,
      hasChild:this.hasChild,
      category_id:this.category_id,
      language_id:this.language_id,
      title:this.title,
    );
  }
}




