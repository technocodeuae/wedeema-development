// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsDetailsModel _$AdsDetailsModelFromJson(Map<String, dynamic> json) =>
    AdsDetailsModel(
      ad: json['ad'] == null
          ? null
          : ItemsAdsModel.fromJson(json['ad'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) =>
              CategoryAdsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageAdsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) =>
              CategoryAdsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map(
              (e) => RatingAdsDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sharing_link: json['sharing_link'] as String?,
    );

Map<String, dynamic> _$AdsDetailsModelToJson(AdsDetailsModel instance) =>
    <String, dynamic>{
      'ad': instance.ad,
      'categories': instance.categories,
      'images': instance.images,
      'properties': instance.properties,
      'ratings': instance.ratings,
      'sharing_link': instance.sharing_link,
    };

CategoryAdsDetailsModel _$CategoryAdsDetailsModelFromJson(
        Map<String, dynamic> json) =>
    CategoryAdsDetailsModel(
      id: json['id'] as int?,
      parent_id: int.parse(json['parent_id'] ??'0'),
      sort_order:int.parse( json['sort_order'] ),
      filter_show: json['filter_show'] as String?,
      slider_show: json['slider_show'] as String?,
      icon: json['icon'] as String?,
      head_img: json['head_img'] as String?,
      status: json['status'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deleted_at: json['deleted_at'],
      has_child: json['has_child'] as int?,
      category_id: int.parse(json['category_id'] ??'0'),
      language_id: int.parse( json['language_id'] ),
      title: json['title'] as String?,
      ad_id: (json['ad_id'] ??'0')  ,
      essential: json['essential'] as String?,
      property_id: int.parse(json['property_id'] ??'0') ,
      subproperty_id: json['subproperty_id'],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CategoryAdsDetailsModelToJson(
        CategoryAdsDetailsModel instance) =>
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
      'has_child': instance.has_child,
      'category_id': instance.category_id,
      'language_id': instance.language_id,
      'title': instance.title,
      'ad_id': instance.ad_id,
      'essential': instance.essential,
      'property_id': instance.property_id,
      'subproperty_id': instance.subproperty_id,
      'description': instance.description,
    };

ImageAdsDetailsModel _$ImageAdsDetailsModelFromJson(
        Map<String, dynamic> json) =>
    ImageAdsDetailsModel(
      id: json['id'] as int?,
      ad_id: (json['ad_id'] ??'0') ,
      featured: json['featured'] as String?,
      name: json['name'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ImageAdsDetailsModelToJson(
        ImageAdsDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ad_id': instance.ad_id,
      'featured': instance.featured,
      'name': instance.name,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };

RatingAdsDetailsModel _$RatingAdsDetailsModelFromJson(
        Map<String, dynamic> json) =>
    RatingAdsDetailsModel(
      id: int.parse(json['id']??'0') ,
      type: json['type'] as String?,
      evaluator_id: int.parse(json['evaluator_id']??'0'),
      evaluated_id: json['evaluated_id'],
      ad_id: (json['ad_id']??'1'),
      value: double.parse(json['value'] ??'0.0'),
      comment: json['comment'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user_name: json['user_name'] as String?,
      user_profile_pic: json['user_profile_pic'] as String?,
      user_id: json['user_id'] as int?,
    );

Map<String, dynamic> _$RatingAdsDetailsModelToJson(
        RatingAdsDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'evaluator_id': instance.evaluator_id,
      'evaluated_id': instance.evaluated_id,
      'ad_id': instance.ad_id,
      'user_id': instance.user_id,
      'value': instance.value,
      'comment': instance.comment,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'user_name': instance.user_name,
      'user_profile_pic': instance.user_profile_pic,
    };
