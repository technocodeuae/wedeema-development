import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import '../ads/ads_model.dart';
import '../profile/profile_model.dart';
import 'entity/more_info_profile_entity.dart';

part 'more_info_profile_model.g.dart';

@JsonSerializable()
class MoreInfoProfileModel extends BaseModel {
  final ItemsUserModel? user;
  final List<ItemsAdsModel>? active_ads;
  final List<ItemsAdsModel>? pending_ads;
  final List<ItemsAdsModel>? favorite_ads;
  final List<ItemsUserModel>? user_followers;
  final List<ItemsUserModel>? user_followings;
  final List<ItemsUserModel>? blocked_users;

  MoreInfoProfileModel({
    this.active_ads,
    this.user,
    this.pending_ads,
    this.user_followings,
    this.user_followers,
    this.blocked_users,
    this.favorite_ads,
  });

  factory MoreInfoProfileModel.fromRawJson(String str) =>
      MoreInfoProfileModel.fromJson(json.decode(str));

  factory MoreInfoProfileModel.fromJson(Map<String, dynamic> json) =>
      _$MoreInfoProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoreInfoProfileModelToJson(this);

  @override
  MoreInfoProfileEntity toEntity() {
    return MoreInfoProfileEntity(
      favorite_ads: favorite_ads?.map((e) => e.toEntity()).toList(),
      blocked_users: blocked_users?.map((e) => e.toEntity()).toList(),
      user_followers: user_followers?.map((e) => e.toEntity()).toList(),
      user_followings: user_followings?.map((e) => e.toEntity()).toList(),
      pending_ads: pending_ads?.map((e) => e.toEntity()).toList(),
      active_ads: active_ads?.map((e) => e.toEntity()).toList(),
      user: user?.toEntity(),
    );
  }
}
