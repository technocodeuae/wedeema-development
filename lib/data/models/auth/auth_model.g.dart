// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateModel _$AuthenticateModelFromJson(Map<String, dynamic> json) =>
    AuthenticateModel(
      access_token: json['access_token'] as String?,
      token_type: json['token_type'] as String?,
      is_signup: json['is_signup'] as String?,
      user: json['user'] == null
          ? null
          : UserAuthenticateModel.fromJson(
              json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticateModelToJson(AuthenticateModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'is_signup': instance.is_signup,
      'user': instance.user,
    };

UserAuthenticateModel _$UserAuthenticateModelFromJson(
        Map<String, dynamic> json) =>
    UserAuthenticateModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      status: json['status'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      mobile: json['mobile'] as String?,
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      profile_pic: json['profile_pic'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      remember_token: json['remember_token'] as String?,
      email_verified_at: json['email_verified_at'] as String?,
      full_mobile_number: json['full_mobile_number'] as String?,
      note: json['note'] as String?,
      about: json['about'] as String?,
      account_type: json['account_type'] as String?,
      advertiser_perecent: json['advertiser_perecent'] as String?,
      apple_provider_id: json['apple_provider_id'] as String?,
      company_name: json['company_name'] as String?,
      country: json['country'] as String?,
      deleted_at: json['deleted_at'] as String?,
      facebook_provider_id: json['facebook_provider_id'] as String?,
      google_provider_id: json['google_provider_id'] as String?,
      is_accept_terms: json['is_accept_terms'] as int?,
      is_active: json['is_active'] as int?,
      is_mobile_verified: json['is_mobile_verified'] as int?,
      is_password_weak: json['is_password_weak'] as int?,
      is_shown_email: json['is_shown_email'] as int?,
      is_shown_mobile: json['is_shown_mobile'] as int?,
      kind: json['kind'] as String?,
      last_login: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
      linkedin_provider_id: json['linkedin_provider_id'] as String?,
      login_token: json['login_token'] as String?,
      mainId: json['mainId'] as int?,
      marketing_company_code: json['marketing_company_code'] as String?,
      platform_id: json['platform_id'] as String?,
      platform_kind: json['platform_kind'] as String?,
      registration_website: json['registration_website'] as String?,
      role_id: json['role_id'] as int?,
      twitter_provider_id: json['twitter_provider_id'] as String?,
      user_image: json['user_image'] as String?,
      user_name: json['user_name'] as String?,
      verification_code: json['verification_code'] as String?,
      verification_link: json['verification_link'] as String?,
      notification_status: json['notification_status'] as String?,
    );

Map<String, dynamic> _$UserAuthenticateModelToJson(
        UserAuthenticateModel instance) =>
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
      'notification_status': instance.notification_status,
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
      'mainId': instance.mainId,
      'company_name': instance.company_name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'kind': instance.kind,
      'gender': instance.gender,
      'is_shown_email': instance.is_shown_email,
      'is_shown_mobile': instance.is_shown_mobile,
      'is_accept_terms': instance.is_accept_terms,
    };
