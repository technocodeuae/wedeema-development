import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/messages_entity.dart';

part 'messages_model.g.dart';
@JsonSerializable()
class MessagesAllDataModel extends BaseModel {
  MessagesAllDataModel({this.messages});

  final List<MessagesModel>? messages;

  factory MessagesAllDataModel.fromRawJson(String str) =>
      MessagesAllDataModel.fromJson(json.decode(str));

  factory MessagesAllDataModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesAllDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesAllDataModelToJson(this);

  @override
  MessagesAllDataEntity toEntity() {
    return MessagesAllDataEntity(
        messages: messages?.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class MessagesModel extends BaseModel {
  final int? id;
  final dynamic user_id_1;
  final dynamic user_id_2;
  final dynamic ad_id;
  final String? message;
  final String? type;
  final String? filename;
  final String? filepath;
  final int? channel;
  final DateTime? created_at;
  final DateTime? updated_at;
  final String? user_name_1;
  final dynamic user_name_2;
  final String? ad_name;
  final String? ad_img;
  final DateTime? ad_created_at;
  final String? profile_pic;

  MessagesModel(
      {this.id,
      this.ad_id,
      this.ad_created_at,
      this.message,
      this.channel,
      this.user_name_2,
      this.user_name_1,
      this.user_id_2,
      this.user_id_1,
      this.ad_name,
      this.ad_img,
      this.created_at,
      this.updated_at,
      this.profile_pic,
      this.type,
      this.filename,
      this.filepath});

  factory MessagesModel.fromRawJson(String str) =>
      MessagesModel.fromJson(json.decode(str));

  factory MessagesModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesModelToJson(this);

  @override
  MessagesEntity toEntity() {
    return MessagesEntity(
      id: this.id,
      ad_id: this.ad_id,
      user_name_2: this.user_name_2,
      user_name_1: this.user_name_1,
      user_id_2: this.user_id_2,
      user_id_1: this.user_id_1,
      created_at: this.created_at,
      updated_at: this.updated_at,
      ad_name: this.ad_name,
      ad_img: this.ad_img,
      ad_created_at: this.ad_created_at,
      message: this.message,
      channel: this.channel,
      profile_pic: this.profile_pic,
      type: this.type,
      filename: this.filename,
      filepath: this.filepath
    );
  }
}
