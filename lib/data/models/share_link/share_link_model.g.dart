// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareLinkModel _$ShareLinkModelFromJson(Map<String, dynamic> json) =>
    ShareLinkModel(
      user: json['user'] == null
          ? null
          : ItemsUserModel.fromJson(json['user'] as Map<String, dynamic>),
      ad: json['ad'] == null
          ? null
          : ItemsAdsModel.fromJson(json['ad'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShareLinkModelToJson(ShareLinkModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'ad': instance.ad,
    };
