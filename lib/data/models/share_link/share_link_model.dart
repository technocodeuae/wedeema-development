import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import '../ads/ads_model.dart';
import '../profile/profile_model.dart';
import 'entity/share_link_entity.dart';

part 'share_link_model.g.dart';

@JsonSerializable()
class ShareLinkModel extends BaseModel {
  final ItemsUserModel? user;
  final ItemsAdsModel? ad;

  ShareLinkModel({
    this.user,
    this.ad,
  });

  factory ShareLinkModel.fromRawJson(String str) =>
      ShareLinkModel.fromJson(json.decode(str));

  factory ShareLinkModel.fromJson(Map<String, dynamic> json) =>
      _$ShareLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShareLinkModelToJson(this);

  @override
  ShareLinkEntity toEntity() {
    return ShareLinkEntity(
      user: user?.toEntity(),
      ad: ad?.toEntity(),
    );
  }
}

