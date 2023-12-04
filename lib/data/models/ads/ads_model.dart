import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:wadeema/data/models/ads_details/ads_details_model.dart';

import '../../../../core/models/base_models.dart';
import 'entity/ads_entity.dart';

part 'ads_model.g.dart';

@JsonSerializable()
class AdsModel extends BaseModel {
  final List<ItemsAdsModel>? data;

  AdsModel({
    this.data,

  });

  factory AdsModel.fromRawJson(String str) =>
      AdsModel.fromJson(json.decode(str));

  factory AdsModel.fromJson(Map<String, dynamic> json) =>
      _$AdsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdsModelToJson(this);

  @override
  AdsEntity toEntity() {
    return AdsEntity(
      data: data?.map((e) => e.toEntity()).toList(),

    );
  }
}

// @JsonSerializable()
// class AdInfoModel extends BaseModel {
//   final List<ItemsAdsModel>? ad;
//   final List<List<CommentAdsModel>>? comments;
//
//   AdInfoModel({
//     this.ad,
//     this.comments,
//   });
//
//   factory AdInfoModel.fromRawJson(String str) =>
//       AdInfoModel.fromJson(json.decode(str));
//
//   factory AdInfoModel.fromJson(Map<String, dynamic> json) =>
//       _$AdInfoModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AdInfoModelToJson(this);
//
//   @override
//   AdInfoEntity toEntity() {
//     return AdInfoEntity(
//       ad: ad?.map((e) => e.toEntity()).toList(),
//       comments:
//           comments?.map((e) => e.map((e1) => e1.toEntity()).toList()).toList(),
//     );
//   }
// }

@JsonSerializable()
class ItemsAdsModel extends BaseModel {
  final int? id;
  final int? ad_id;
  final int? user_id;
  final int? language_id;
  final String? title;
  final String? short_description;
  final String? full_description;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final String? user_name;
  final String? profile_pic;
  final String? currency;
  final String? city;
  final List<AdImagesModel>? ad_images;
  final List<CategoryAdsDetailsModel>? properties;
  final int? price;
  final dynamic average;
  final int? followers_count;
  final DateTime? date_ad;
  final String? category_title;
  final String? status;
  final String? image_name;
  final String? featured_image;
  final String? availability_status;
  final String? sub_category_title;
  int is_favorite;
  int is_liked;
  int likes;
  int? category_id;
  final List<AdEvaluationsModel>? ad_evaluations;
 final String? sharing_link;
  ItemsAdsModel(
      {this.id,
      this.ad_id,
      this.language_id,
      this.title,
      this.short_description,
      this.full_description,
      this.created_at,
      this.updated_at,
      this.deleted_at,
      this.user_name,
      this.profile_pic,
      this.currency,
      this.city,
      this.price,
      this.average,
        this.sharing_link,
      this.followers_count,
      this.date_ad,
      this.ad_images,
      this.properties,
      this.category_title,
      this.status,
      this.likes = 0,
      this.availability_status,
      this.is_favorite = 0,
      this.is_liked = 0,
      this.user_id,
      this.category_id,
      this.image_name,
      this.featured_image,
      this.sub_category_title,
      this.ad_evaluations});

  factory ItemsAdsModel.fromRawJson(String str) =>
      ItemsAdsModel.fromJson(json.decode(str));

  factory ItemsAdsModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsAdsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsAdsModelToJson(this);

  @override
  ItemsAdsEntity toEntity() {
    return ItemsAdsEntity(
      id: this.id,
        sharing_link:this.sharing_link,
      ad_id: this.ad_id,
      language_id: this.language_id,
      title: this.title,
      short_description: this.short_description,
      full_description: this.full_description,
      created_at: this.created_at,
      updated_at: this.updated_at,
      deleted_at: this.deleted_at,
      user_name: this.user_name,
      profile_pic: this.profile_pic,
      currency: this.currency,
      city: this.city,
      price: this.price,
      average: this.average,
      followers_count: this.followers_count,
        date_ad: this.date_ad,
      ad_images: this.ad_images?.map((e) => e.toEntity()).toList(),
        properties: this.properties?.map((e) => e.toEntity()).toList(),
        category_title: this.category_title,
      user_id: this.user_id,
      status: this.status,
      availability_status: this.availability_status,
      is_favorite: this.is_favorite,
      is_liked: this.is_liked,
      likes: this.likes,category_id: this.category_id,
      ad_evaluations: this.ad_evaluations?.map((e) => e.toEntity()).toList(),
      image_name: this.image_name,
      featured_image: this.featured_image,
      sub_category_title: this.sub_category_title
    );
  }
}

@JsonSerializable()
class AdImagesModel extends BaseModel {
  AdImagesModel({
    this.name,
    this.featured,
    this.created_at,
  });

  final String? featured;
  final String? name;
  final DateTime? created_at;

  factory AdImagesModel.fromRawJson(String str) =>
      AdImagesModel.fromJson(json.decode(str));

  factory AdImagesModel.fromJson(Map<String, dynamic> json) =>
      _$AdImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdImagesModelToJson(this);

  @override
  AdImagesEntity toEntity() {
    return AdImagesEntity(
      created_at: this.created_at,
      featured: this.featured,
      name: this.name,
    );
  }
}

@JsonSerializable()
class AdEvaluationsModel extends BaseModel {
  AdEvaluationsModel({
    this.evaluator_name,
    this.value,
    this.created_at,
  });

  final String? evaluator_name;
  final double? value;
  final DateTime? created_at;

  factory AdEvaluationsModel.fromRawJson(String str) =>
      AdEvaluationsModel.fromJson(json.decode(str));

  factory AdEvaluationsModel.fromJson(Map<String, dynamic> json) =>
      _$AdEvaluationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdEvaluationsModelToJson(this);

  @override
  AdEvaluationsEntity toEntity() {
    return AdEvaluationsEntity(
      created_at: this.created_at,
      evaluator_name: this.evaluator_name,
      value: this.value,
    );
  }
}

// @JsonSerializable()
// class CommentAdsModel extends BaseModel {
//   final int? id;
//   final String? type;
//   final int? evaluator_id;
//   final dynamic evaluated_id;
//   final int? ad_id;
//   final double? value;
//   final String? comment;
//   final DateTime? created_at;
//   final DateTime? updated_at;
//   final String? user_name;
//   final String? user_profile_pic;
//
//   CommentAdsModel({
//     this.id,
//     this.type,
//     this.evaluator_id,
//     this.evaluated_id,
//     this.ad_id,
//     this.value,
//     this.comment,
//     this.created_at,
//     this.user_name,
//     this.user_profile_pic,
//     this.updated_at,
//   });
//
//   factory CommentAdsModel.fromRawJson(String str) =>
//       CommentAdsModel.fromJson(json.decode(str));
//
//   factory CommentAdsModel.fromJson(Map<String, dynamic> json) =>
//       _$CommentAdsModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CommentAdsModelToJson(this);
//
//   @override
//   CommentAdsEntity toEntity() {
//     return CommentAdsEntity(
//       id: this.id,
//       ad_id: this.ad_id,
//       user_profile_pic: this.user_profile_pic,
//       evaluated_id: this.evaluated_id,
//       evaluator_id: this.evaluator_id,
//       comment: this.comment,
//       created_at: this.created_at,
//       updated_at: this.updated_at,
//       value: this.value,
//       user_name: this.user_name,
//       type: this.type,
//     );
//   }
// }
