// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsModel _$AdsModelFromJson(Map<String, dynamic> json) => AdsModel(
      data: (json['data'] as List<dynamic>?)?.map((e) => ItemsAdsModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$AdsModelToJson(AdsModel instance) => <String, dynamic>{
      'data': instance.data,
    };

ItemsAdsModel _$ItemsAdsModelFromJson(Map<String, dynamic> json) => ItemsAdsModel(
      id: json['id'] as int?,
      ad_id: (json['ad_id']),
      language_id: int.parse(json['language_id'] ),
      image_name: json['image_name'] as String?,
      featured_image: json['featured_image'] as String?,
      sub_category_title: json['sub_category_title'] as String?,
      title: json['title'] as String?,
      short_description: json['short_description'] as String?,
      full_description: json['full_description'] as String?,
      created_at: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      deleted_at: json['deleted_at'],
      user_name: json['user_name'] as String?,
      profile_pic: json['profile_pic'] as String?,
      currency: json['currency'] as String?,
      city: json['city'] as String?,
      price: json['price'] as int?,
      average: json['average'],
      sharing_link: json['sharing_link'] as String?,
      followers_count: int.parse(json['followers_count'] ?? '0') ,
      date_ad: json['date_ad'] == null ? null : DateTime.parse(json['date_ad'] as String),
      ad_images: json['ad_images'] is List
          ? ((json['ad_images'] as List<dynamic>?)
              ?.map((e) => AdImagesModel.fromJson(e as Map<String, dynamic>))
              .toList())
          : [],
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) =>
          CategoryAdsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      category_title: json['category_title'] as String?,
      category_id: int.parse(json['category_id'] ??'0') ,
      status: json['status'] as String?,
      likes: int.parse(json['likes'] ??'0') ,
      availability_status: json['availability_status'] as String?,
      is_favorite:int.parse( json['is_favorite'] ??'0'),
      is_liked: int.parse(json['is_liked'] ??'0'),
      user_id: int.parse(json['user_id'] ??'0'),
      ad_evaluations: json['ad_evaluations'] is List
          ? ((json['ad_evaluations'] as List<dynamic>?)
              ?.map((e) => AdEvaluationsModel.fromJson(e as Map<String, dynamic>))
              .toList())
          : [],
    );

Map<String, dynamic> _$ItemsAdsModelToJson(ItemsAdsModel instance) => <String, dynamic>{
      'id': instance.id,
      'ad_id': instance.ad_id,
      'user_id': instance.user_id,
      'language_id': instance.language_id,
      'title': instance.title,
      'short_description': instance.short_description,
      'full_description': instance.full_description,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'deleted_at': instance.deleted_at,
      'user_name': instance.user_name,
      'profile_pic': instance.profile_pic,
      'currency': instance.currency,
      'city': instance.city,
      'ad_images': instance.ad_images,
      'price': instance.price,
      'average': instance.average,
      'followers_count': instance.followers_count,
      'date_ad': instance.date_ad?.toIso8601String(),
      'category_title': instance.category_title,
      'status': instance.status,
      'availability_status': instance.availability_status,
      'is_favorite': instance.is_favorite,
      'is_liked': instance.is_liked,
      'likes': instance.likes,
      'ad_evaluations': instance.ad_evaluations,
      'sharing_link': instance.sharing_link,
      'image_name': instance.image_name,
      'featured_image': instance.featured_image,
      'sub_category_title': instance.sub_category_title,
    };

AdImagesModel _$AdImagesModelFromJson(Map<String, dynamic> json) => AdImagesModel(
      name: json['name'] as String?,
      featured: json['featured'] as String?,
      created_at: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AdImagesModelToJson(AdImagesModel instance) => <String, dynamic>{
      'featured': instance.featured,
      'name': instance.name,
      'created_at': instance.created_at?.toIso8601String(),
    };

AdEvaluationsModel _$AdEvaluationsModelFromJson(Map<String, dynamic> json) => AdEvaluationsModel(
      evaluator_name: json['evaluator_name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      created_at: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AdEvaluationsModelToJson(AdEvaluationsModel instance) => <String, dynamic>{
      'evaluator_name': instance.evaluator_name,
      'value': instance.value,
      'created_at': instance.created_at?.toIso8601String(),
    };
