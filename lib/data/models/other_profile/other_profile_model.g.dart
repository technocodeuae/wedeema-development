// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherProfileModel _$OtherProfileModelFromJson(Map<String, dynamic> json) =>
    OtherProfileModel(
      user_followings: (json['user_followings'] as List<dynamic>?)
          ?.map((e) => ItemsUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : ItemsUserModel.fromJson(json['user'] as Map<String, dynamic>),
      active_ads: (json['active_ads'] as List<dynamic>?)
          ?.map((e) => ItemsAdsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user_followers: (json['user_followers'] as List<dynamic>?)
          ?.map((e) => ItemsUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_follow: json['is_follow'] as bool?,
      is_blocked: json['is_blocked'] as bool?,
      sharing_link: json['sharing_link'] as String?,
          adCount: json['ad_count'] as int?,
    );

Map<String, dynamic> _$OtherProfileModelToJson(OtherProfileModel instance) =>
    <String, dynamic>{
      'active_ads': instance.active_ads,
      'user': instance.user,
      'user_followers': instance.user_followers,
      'user_followings': instance.user_followings,
      'is_follow': instance.is_follow,
      'is_blocked': instance.is_blocked,
      'sharing_link': instance.sharing_link,
          'ad_count':instance.adCount
    };
