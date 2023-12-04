import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../../core/models/base_entity.dart';


class AdsEntity extends BaseEntity {
  final List<ItemsAdsEntity>? data;



  AdsEntity({

    this.data,
  });

  @override
  List<Object?> get props => [
    this.data,

  ];


}


// class AdInfoEntity extends BaseEntity {
//   final List<ItemsAdsEntity>? ad;
//
//
//   AdInfoEntity({
//     this.ad,
//
//   });
//
//   @override
//   List<Object?> get props => [
//     this.ad,
//
//   ];
//
//
// }

class ItemsAdsEntity extends BaseEntity {
  ItemsAdsEntity({
    this.id,
    this.sharing_link,
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
    this.followers_count,
    this.date_ad,
    this.ad_images,
    this.properties,
    this.category_title,
    this.status,
    this.likes = 0,
    this.availability_status,
    this.is_favorite = 0,
    this.user_id,
    this.is_liked=0,
    this.ad_evaluations,
    this.category_id,
    this.image_name,
    this.featured_image,
    this.sub_category_title,
  });

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
  final List<AdImagesEntity>? ad_images;
  final String? image_name;
  final String? featured_image;
  final List<CategoryAdsDetailsEntity>? properties;
  final int? price;
  final dynamic average;
  final int? followers_count;
  final DateTime? date_ad;
  final String? category_title;
  final String? sub_category_title;
  final int? category_id;
  final String? status;
  final String? availability_status;
   int is_favorite;
   int is_liked;
   int likes;
  final List<AdEvaluationsEntity>? ad_evaluations;
  final String? sharing_link;

  @override
  List<Object?> get props => [
    this.id,
    this.sharing_link,
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
    this.followers_count,
    this.date_ad,
    this.ad_images,
    this.properties,
    this.category_title,
    this.sub_category_title,
    this.status,
    this.likes,
    this.availability_status,
    this.is_favorite,
    this.user_id,
    this.is_liked,
    this.category_id,
    this.image_name,
    this.featured_image,
  ];

}

class AdImagesEntity extends BaseEntity {
  AdImagesEntity({
    this.name,
    this.featured,

    this.created_at,

  });

  final String? featured;
  final String? name;
  final DateTime? created_at;

  @override
  List<Object?> get props => [
    this.name,
    this.featured,
    this.created_at,
  ];

}

class AdEvaluationsEntity extends BaseEntity {
  AdEvaluationsEntity({
    this.evaluator_name,
    this.value,
    this.created_at,

  });

  final String? evaluator_name;
  final double? value;
  final DateTime? created_at;

  @override
  List<Object?> get props => [
    this.evaluator_name,
    this.value,
    this.created_at,
  ];

}







