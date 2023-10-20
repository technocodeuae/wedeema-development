// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_info_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoreInfoProfileModel _$MoreInfoProfileModelFromJson(
        Map<String, dynamic> json) =>
    MoreInfoProfileModel(
      active_ads: (json['active_ads'] as List<dynamic>?)
          ?.map((e) => ItemsAdsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : ItemsUserModel.fromJson(json['user'] as Map<String, dynamic>),
      pending_ads: (json['pending_ads'] as List<dynamic>?)
          ?.map((e) => ItemsAdsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user_followings: (json['user_followings'] as List<dynamic>?)
          ?.map((e) => ItemsUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user_followers: (json['user_followers'] as List<dynamic>?)
          ?.map((e) => ItemsUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      blocked_users: (json['blocked_users'] as List<dynamic>?)
          ?.map((e) => ItemsUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      favorite_ads: (json['favorite_ads'] as List<dynamic>?)
          ?.map((e) => ItemsAdsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoreInfoProfileModelToJson(
        MoreInfoProfileModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'active_ads': instance.active_ads,
      'pending_ads': instance.pending_ads,
      'favorite_ads': instance.favorite_ads,
      'user_followers': instance.user_followers,
      'user_followings': instance.user_followings,
      'blocked_users': instance.blocked_users,
    };
