import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import '../ads/ads_model.dart';
import '../profile/profile_model.dart';
import 'entity/other_profile_entity.dart';

part 'other_profile_model.g.dart';

@JsonSerializable()
class OtherProfileModel extends BaseModel {
  final List<ItemsAdsModel>? active_ads;
  final ItemsUserModel? user;
  final List<ItemsUserModel>? user_followers;
  final List<ItemsUserModel>? user_followings;
  final bool? is_follow;
  final bool? is_blocked;
  final String? sharing_link;
  final int? adCount;

  OtherProfileModel({
    this.user_followings,
    this.user,
    this.active_ads,
    this.user_followers,
    this.is_follow,
    this.is_blocked,
    this.sharing_link,
    this.adCount
  });

  factory OtherProfileModel.fromRawJson(String str) =>
      OtherProfileModel.fromJson(json.decode(str));

  factory OtherProfileModel.fromJson(Map<String, dynamic> json) =>
      _$OtherProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtherProfileModelToJson(this);

  @override
  OtherProfileEntity toEntity() {
    return OtherProfileEntity(
      active_ads:  active_ads?.map((e) => e.toEntity()).toList(),
      user_followers:  user_followers?.map((e) => e.toEntity()).toList(),
      user_followings:  user_followings?.map((e) => e.toEntity()).toList(),
      user: user?.toEntity(),
      is_follow: is_follow,
      is_blocked: is_blocked,
        sharing_link:sharing_link,
      adCount: adCount??0
    );
  }
}


