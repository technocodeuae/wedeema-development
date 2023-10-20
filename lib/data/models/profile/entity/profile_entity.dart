import '../../../../core/models/base_entity.dart';
import '../../ads/entity/ads_entity.dart';


class ProfileEntity extends BaseEntity {
  final List<ItemsAdsEntity>? ad;
  final ItemsUserEntity? user;



  ProfileEntity({
    this.ad,
    this.user,

  });

  @override
  List<Object?> get props => [
    this.ad,
    this.user,

  ];


}


class ItemsUserEntity extends BaseEntity {
  ItemsUserEntity({
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

  final int? id;
  final int? role_id;
  final String? email;
  final DateTime? last_login;
  final String? user_name;
  final String? first_name;
  final String? last_name;
  final String? mobile;
  final dynamic full_mobile_number;
  final dynamic is_mobile_verified;
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
  final dynamic is_active;
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
  final int? city_id;
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
  final dynamic ratings_average;


  @override
  List<Object?> get props => [
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
    this.city_id,
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

  ];

}







