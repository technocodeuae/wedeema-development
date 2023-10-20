import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import '../ads/ads_model.dart';
import 'entity/ads_details_entity.dart';

part 'ads_details_model.g.dart';

@JsonSerializable()
class AdsDetailsModel extends BaseModel {
  final ItemsAdsModel? ad;
  final List<CategoryAdsDetailsModel>? categories;
  final List<ImageAdsDetailsModel>? images;
  final List<CategoryAdsDetailsModel>? properties;
  final List<RatingAdsDetailsModel>? ratings;
  final String? sharing_link;

  AdsDetailsModel({
    this.ad,
    this.categories,
    this.images,
    this.properties,
    this.ratings,
    this.sharing_link,
  });

  factory AdsDetailsModel.fromRawJson(String str) =>
      AdsDetailsModel.fromJson(json.decode(str));

  factory AdsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AdsDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdsDetailsModelToJson(this);

  @override
  AdsDetailsEntity toEntity() {
    return AdsDetailsEntity(
      ad: ad?.toEntity(),
        sharing_link:sharing_link,
      categories: categories?.map((e) => e.toEntity()).toList(),
      images: images?.map((e) => e.toEntity()).toList(),
      ratings: ratings?.map((e) => e.toEntity()).toList(),
      properties: properties?.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class CategoryAdsDetailsModel extends BaseModel {
  final int? id;
  final int? parent_id;
  final int? sort_order;
  final String? filter_show;
  final String? slider_show;
  final String? type;
  final String? icon;
  final String? head_img;
  final String? status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final int? has_child;
  final int? category_id;
  final int? language_id;
  final String? title;
  final int? ad_id;
  final String? essential;
  final int? property_id;
  final dynamic subproperty_id;
  final String? description;

  CategoryAdsDetailsModel({
    this.id,
    this.parent_id,
    this.sort_order,
    this.filter_show,
    this.slider_show,
    this.type,
    this.icon,
    this.head_img,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.has_child,
    this.category_id,
    this.language_id,
    this.title,
    this.ad_id,
    this.essential,
    this.property_id,
    this.subproperty_id,
    this.description,
  });

  factory CategoryAdsDetailsModel.fromRawJson(String str) =>
      CategoryAdsDetailsModel.fromJson(json.decode(str));

  factory CategoryAdsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryAdsDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryAdsDetailsModelToJson(this);

  @override
  CategoryAdsDetailsEntity toEntity() {
    return CategoryAdsDetailsEntity(
      id: this.id,
      ad_id: this.ad_id,
      language_id: this.language_id,
      title: this.title,
      status: this.status,
      icon: this.icon,
      created_at: this.created_at,
      updated_at: this.updated_at,
      deleted_at: this.deleted_at,
      category_id: this.category_id,
      description: this.description,
      essential: this.essential,
      parent_id: this.parent_id,
      filter_show: this.filter_show,
      head_img: this.head_img,
      has_child: this.has_child,
      slider_show: this.slider_show,
      type: this.type,
      property_id: this.property_id,
      sort_order: this.sort_order,
      subproperty_id: this.subproperty_id,
    );
  }
}

@JsonSerializable()
class ImageAdsDetailsModel extends BaseModel {
  final int? id;
  final int? ad_id;
  final String? featured;
  final String? name;
  final DateTime? created_at;
  final DateTime? updated_at;

  ImageAdsDetailsModel({
    this.id,
    this.ad_id,
    this.featured,
    this.name,
    this.created_at,
    this.updated_at,
  });

  factory ImageAdsDetailsModel.fromRawJson(String str) =>
      ImageAdsDetailsModel.fromJson(json.decode(str));

  factory ImageAdsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ImageAdsDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageAdsDetailsModelToJson(this);

  @override
  ImageAdsDetailsEntity toEntity() {
    return ImageAdsDetailsEntity(
      id: this.id,
      ad_id: this.ad_id,
      created_at: this.created_at,
      updated_at: this.updated_at,
      name: this.name,
      featured: this.featured,
    );
  }
}

@JsonSerializable()
class RatingAdsDetailsModel extends BaseModel {
  final int? id;
  final String? type;
  final int? evaluator_id;
  final dynamic evaluated_id;
  final int? ad_id;
  final int? user_id;
  final dynamic value;
  final String? comment;
  final DateTime? created_at;
  final DateTime? updated_at;
  final String? user_name;
  final String? user_profile_pic;

  RatingAdsDetailsModel({
    this.id,
    this.type,
    this.evaluator_id,
    this.evaluated_id,
    this.ad_id,
    this.value,
    this.comment,
    this.created_at,
    this.updated_at,
    this.user_name,
    this.user_profile_pic,
    this.user_id,
  });

  factory RatingAdsDetailsModel.fromRawJson(String str) =>
      RatingAdsDetailsModel.fromJson(json.decode(str));

  factory RatingAdsDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RatingAdsDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingAdsDetailsModelToJson(this);

  @override
  RatingAdsDetailsEntity toEntity() {
    return RatingAdsDetailsEntity(
        id: this.id,
        ad_id: this.ad_id,
        created_at: this.created_at,
        updated_at: this.updated_at,
        comment: this.comment,
        evaluated_id: this.evaluated_id,
        evaluator_id: this.evaluator_id,
        user_name: this.user_name,
        type: this.type,
        value: this.value,
        user_profile_pic: this.user_profile_pic,
        user_id: this.user_id);
  }
}
