import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthenticateModel extends BaseModel {
  final String? access_token;
  final String? token_type;
  final String? is_signup;

  final UserAuthenticateModel? user;

  AuthenticateModel({
    this.access_token,
    this.token_type,
    this.is_signup,
    this.user,
  });

  factory AuthenticateModel.fromRawJson(String str) =>
      AuthenticateModel.fromJson(json.decode(str));

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateModelToJson(this);

  @override
  AuthenticateEntity toEntity() {
    return AuthenticateEntity(
        access_token: access_token,
        token_type: token_type,
        is_signup: is_signup,
        user: user?.toEntity()    );
  }
}



@JsonSerializable()
class UserAuthenticateModel extends BaseModel {
  UserAuthenticateModel({
    this.id,
    this.email,
    this.gender,
    this.first_name,
    this.last_name,
    this.status,
    this.city,
    this.address,
    this.longitude,
    this.latitude,
    this.mobile,
    this.updated_at,
    this.profile_pic,
    this.created_at,
    this.remember_token,
    this.email_verified_at,
    this.full_mobile_number,
    this.note,
    this.about,
    this.account_type,
    this.advertiser_perecent,
    this.apple_provider_id,
    this.company_name,
    this.country,
    this.deleted_at,
    this.facebook_provider_id,
    this.google_provider_id,
    this.is_accept_terms,
    this.is_active,
    this.is_mobile_verified,
    this.is_password_weak,
    this.is_shown_email,
    this.is_shown_mobile,
    this.kind,
    this.last_login,
    this.linkedin_provider_id,
    this.login_token,
    this.mainId,
    this.marketing_company_code,
    this.platform_id,
    this.platform_kind,
    this.registration_website,
    this.role_id,
    this.twitter_provider_id,
    this.user_image,
    this.user_name,
    this.verification_code,
    this.verification_link,
    this.notification_status,
  });

  final int? id;
  final int? role_id;
  final String? email;
  final DateTime? last_login;
  final String? user_name;
  final String? first_name;
  final String? last_name;
  final String? mobile;
  final String? full_mobile_number;
  final int? is_mobile_verified;
  final String? profile_pic;
  final String? advertiser_perecent;
  final String? account_type;
  final String? registration_website;
  final String? user_image;
  final String? google_provider_id;
  final String? facebook_provider_id;
  final String? twitter_provider_id;
  final String? linkedin_provider_id;
  final String? apple_provider_id;
  final String? about;
  final int? is_active;
  final int? is_password_weak;
  final String? address;
  final String? note;
  final String? notification_status;
  final String? verification_code;
  final String? email_verified_at;
  final String? remember_token;
  final String? verification_link;
  final String? platform_kind;
  final String? platform_id;
  final String? city;
  final String? country;
  final String? marketing_company_code;
   final   DateTime? created_at;
 final DateTime? updated_at;
  final String? deleted_at;
  final String? status;
  final String? login_token;
  final int? mainId;
  final String? company_name;
  final String? longitude;
  final String? latitude;
  final String? kind;
  final String? gender;
 final int? is_shown_email;
     final  int? is_shown_mobile;
  final int? is_accept_terms;


  factory UserAuthenticateModel.fromRawJson(String str) =>
      UserAuthenticateModel.fromJson(json.decode(str));

  factory UserAuthenticateModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthenticateModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthenticateModelToJson(this);


  @override
  UserAuthenticateEntity toEntity() {
    return UserAuthenticateEntity(
      id:id,
      email:email,
      gender:gender,
      first_name:first_name,
      last_name:last_name,
      status:status,
      city:city,
      address:address,
      longitude:longitude,
      latitude:latitude,
      mobile:mobile,
      updated_at:updated_at,
      profile_pic:profile_pic,
      created_at:created_at,
      remember_token:remember_token,
      email_verified_at:email_verified_at,
      full_mobile_number:full_mobile_number,
      note:note,
      notification_status:notification_status,
      about:about,
      account_type:account_type,
      advertiser_perecent:advertiser_perecent,
      apple_provider_id:apple_provider_id,
      company_name: company_name,
      country:country,
      deleted_at:deleted_at,
      facebook_provider_id:facebook_provider_id,
      google_provider_id:google_provider_id,
      is_accept_terms:is_accept_terms,
      is_active:is_active,
      is_mobile_verified:is_mobile_verified,
      is_password_weak:is_password_weak,
      is_shown_email:is_shown_email,
      is_shown_mobile:is_shown_mobile,
      kind:kind,
      last_login:last_login,
      linkedin_provider_id:linkedin_provider_id,
      login_token:login_token,
      mainId:mainId,
      marketing_company_code:marketing_company_code,
      platform_id:platform_id,
      platform_kind:platform_kind,
      registration_website:registration_website,
      role_id:role_id,
      twitter_provider_id:twitter_provider_id,
      user_image:user_image,
      user_name:user_name,
      verification_code:verification_code,
      verification_link:verification_link,
    );

  }
}

