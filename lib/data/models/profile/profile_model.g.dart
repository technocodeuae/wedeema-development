// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      ad: (json['ad'] as List<dynamic>?)
          ?.map((e) => ItemsAdsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : ItemsUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'ad': instance.ad,
      'user': instance.user,
    };

ItemsUserModel _$ItemsUserModelFromJson(Map<String, dynamic> json) =>
    ItemsUserModel(
      id: json['id'] as int?,
      gender: json['gender'],
      longitude: json['longitude'] as String?,
      latitude: json['latitude'],
      email: json['email'] as String?,
      status: json['status'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deleted_at: json['deleted_at'],
      user_name: json['user_name'] as String?,
      profile_pic: json['profile_pic'] as String?,
      last_name: json['last_name'] as String?,
      city: json['city'] as String?,
      first_name: json['first_name'] as String?,
      is_active: json['is_active'] as int?,
      ratings_average: json['ratings_average'],
      address: json['address'] as String?,
      advertiser_perecent: json['advertiser_perecent'],
      apple_provider_id: json['apple_provider_id'],
      is_mobile_verified: json['is_mobile_verified'] as int?,
      following: json['following'] as int?,
      is_accept_terms: json['is_accept_terms'] as int?,
      google_provider_id: json['google_provider_id'],
      facebook_provider_id: json['facebook_provider_id'],
      country: json['country'],
      is_password_weak: json['is_password_weak'] as int?,
      is_shown_email: json['is_shown_email'] as int?,
      is_shown_mobile: json['is_shown_mobile'] as int?,
      last_login: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
      linkedin_provider_id: json['linkedin_provider_id'],
      login_token: json['login_token'] as String?,
      main_id: json['main_id'] as int?,
      platform_id: json['platform_id'],
      marketing_company_code: json['marketing_company_code'] as String?,
      kind: json['kind'] as String?,
      platform_kind: json['platform_kind'] as String?,
      registration_website: json['registration_website'],
      role_id: json['role_id'] as int?,
      twitter_provider_id: json['twitter_provider_id'],
      user_image: json['user_image'],
      verification_code: json['verification_code'],
      verification_link: json['verification_link'],
      account_type: json['account_type'] as String?,
      about: json['about'],
      remember_token: json['remember_token'],
      email_verified_at: json['email_verified_at'],
      full_mobile_number: json['full_mobile_number'],
      note: json['note'],
      mobile: json['mobile'] as String?,
      company_name: json['company_name'],
      followers: json['followers'] as int?,
      city_id: json['city_id'] as int?,
    );

Map<String, dynamic> _$ItemsUserModelToJson(ItemsUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role_id': instance.role_id,
      'email': instance.email,
      'last_login': instance.last_login?.toIso8601String(),
      'user_name': instance.user_name,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'mobile': instance.mobile,
      'full_mobile_number': instance.full_mobile_number,
      'is_mobile_verified': instance.is_mobile_verified,
      'profile_pic': instance.profile_pic,
      'advertiser_perecent': instance.advertiser_perecent,
      'account_type': instance.account_type,
      'registration_website': instance.registration_website,
      'user_image': instance.user_image,
      'google_provider_id': instance.google_provider_id,
      'facebook_provider_id': instance.facebook_provider_id,
      'twitter_provider_id': instance.twitter_provider_id,
      'linkedin_provider_id': instance.linkedin_provider_id,
      'apple_provider_id': instance.apple_provider_id,
      'about': instance.about,
      'is_active': instance.is_active,
      'is_password_weak': instance.is_password_weak,
      'address': instance.address,
      'note': instance.note,
      'verification_code': instance.verification_code,
      'email_verified_at': instance.email_verified_at,
      'remember_token': instance.remember_token,
      'verification_link': instance.verification_link,
      'platform_kind': instance.platform_kind,
      'platform_id': instance.platform_id,
      'city': instance.city,
      'country': instance.country,
      'marketing_company_code': instance.marketing_company_code,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'deleted_at': instance.deleted_at,
      'status': instance.status,
      'login_token': instance.login_token,
      'main_id': instance.main_id,
      'company_name': instance.company_name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'kind': instance.kind,
      'gender': instance.gender,
      'is_shown_email': instance.is_shown_email,
      'is_shown_mobile': instance.is_shown_mobile,
      'is_accept_terms': instance.is_accept_terms,
      'followers': instance.followers,
      'following': instance.following,
      'city_id': instance.city_id,
      'ratings_average': instance.ratings_average,
    };
