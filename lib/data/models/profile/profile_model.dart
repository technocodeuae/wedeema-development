import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import '../ads/ads_model.dart';
import 'entity/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends BaseModel {
  final List<ItemsAdsModel>? ad;
  final ItemsUserModel? user;
  final  int? adCount;

  ProfileModel({
    this.ad,
    this.user,
    this.adCount
  });

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  ProfileEntity toEntity() {
    return ProfileEntity(
      ad: ad?.map((e) => e.toEntity()).toList(),
      user: user?.toEntity(),
adCount: adCount ??0,
    );
  }
}

@JsonSerializable()
class ItemsUserModel extends BaseModel {
  final int? id;
  final int? role_id;
  final String? email;
  final DateTime? last_login;
  final String? user_name;
  final String? first_name;
  final String? last_name;
  final String? mobile;
  final dynamic full_mobile_number;
  final int? is_mobile_verified;
  final String? profile_pic;
  final dynamic advertiser_perecent;
  final String? account_type;
  final dynamic registration_website;
  final dynamic user_image;
  final dynamic google_provider_id;
  final dynamic facebook_provider_id;
  final dynamic twitter_provider_id;
  final dynamic linkedin_provider_id;
  final dynamic apple_provider_id;
  final dynamic about;
  final int? is_active;
  final int? is_password_weak;
  final String? address;
  final dynamic note;
  final dynamic verification_code;
  final dynamic email_verified_at;
  final dynamic remember_token;
  final dynamic verification_link;
  final String? platform_kind;
  final dynamic platform_id;
  final String? city;
  final dynamic country;
  final String? marketing_company_code;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final String? status;
  final String? login_token;
  final int? main_id;
  final dynamic company_name;
  final String? longitude;
  final dynamic latitude;
  final String? kind;
  final dynamic gender;
  final int? is_shown_email;
  final int? is_shown_mobile;
  final int? is_accept_terms;
  final int? followers;
  final int? following;
  final int? city_id;
  final dynamic ratings_average;

  ItemsUserModel({
    this.id,
    this.gender,
    this.longitude,
    this.latitude,
    this.email,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.user_name,
    this.profile_pic,
    this.last_name,
    this.city,
    this.first_name,
    this.is_active,
    this.ratings_average,
    this.address,
    this.advertiser_perecent,
    this.apple_provider_id,
    this.is_mobile_verified,
    this.following,
    this.is_accept_terms,
    this.google_provider_id,
    this.facebook_provider_id,
    this.country,
    this.is_password_weak,
    this.is_shown_email,
    this.is_shown_mobile,
    this.last_login,
    this.linkedin_provider_id,
    this.login_token,
    this.main_id,
    this.platform_id,
    this.marketing_company_code,
    this.kind,
    this.platform_kind,
    this.registration_website,
    this.role_id,
    this.twitter_provider_id,
    this.user_image,
    this.verification_code,
    this.verification_link,
    this.account_type,
    this.about,
    this.remember_token,
    this.email_verified_at,
    this.full_mobile_number,
    this.note,
    this.mobile,
    this.company_name,
    this.followers,
    this.city_id,
  });

  factory ItemsUserModel.fromRawJson(String str) =>
      ItemsUserModel.fromJson(json.decode(str));

  factory ItemsUserModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsUserModelToJson(this);

  @override
  ItemsUserEntity toEntity() {
    return ItemsUserEntity(
      id: this.id,
      followers: this.followers,
      company_name: this.company_name,
      mobile: this.mobile,
      note: this.note,
      full_mobile_number: this.full_mobile_number,
      created_at: this.created_at,
      updated_at: this.updated_at,
      deleted_at: this.deleted_at,
      user_name: this.user_name,
      profile_pic: this.profile_pic,
      email_verified_at: this.email_verified_at,
      city: this.city,
      remember_token: this.remember_token,
      about: this.about,
      ratings_average: this.ratings_average,
      account_type: this.account_type,
      verification_link: this.verification_link,
      verification_code: this.verification_code,
      user_image: this.user_image,
      twitter_provider_id: this.twitter_provider_id,
      role_id: this.role_id,
      registration_website: this.registration_website,
      platform_kind: this.platform_kind,
      kind: this.kind,
      platform_id: this.platform_id,
      marketing_company_code: this.marketing_company_code,
      login_token: this.login_token,
      linkedin_provider_id: this.linkedin_provider_id,
      last_login: this.last_login,
      is_shown_mobile: this.is_shown_mobile,
      is_shown_email: this.is_shown_email,
      main_id: this.main_id,
      gender: this.gender,
      is_password_weak: this.is_password_weak,
      country: this.country,
      facebook_provider_id: this.facebook_provider_id,
      google_provider_id: this.google_provider_id,
      longitude: this.longitude,
      latitude: this.latitude,
      is_accept_terms: this.is_accept_terms,
      following: this.following,
       is_mobile_verified: this.is_mobile_verified,
      apple_provider_id: this.apple_provider_id,
      advertiser_perecent: this.advertiser_perecent,
      address: this.address,
      is_active: this.is_active,
      first_name: this.first_name,
      last_name: this.last_name,
      status: this.status,
      email: this.email,
        city_id:this.city_id,
    );
  }
}
