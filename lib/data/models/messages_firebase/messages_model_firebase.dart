import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/messages_entity_firebase.dart';

part 'messages_model.g_firebase.dart';
@JsonSerializable()
class MessagesAllDataFirebaseModel extends BaseModel {
  MessagesAllDataFirebaseModel({this.messages});

  final List<MessagesModelFirebase>? messages;

  factory MessagesAllDataFirebaseModel.fromRawJson(String str) =>
      MessagesAllDataFirebaseModel.fromJson(json.decode(str));

  factory MessagesAllDataFirebaseModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesAllDataFirebaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesAllDataFirebaseModelToJson(this);

  @override
  MessagesAllDataFirebaseEntity toEntity() {
    return MessagesAllDataFirebaseEntity(
        messages: messages!.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class MessagesModelFirebase extends BaseModel {
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

  MessagesModelFirebase(
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

  factory MessagesModelFirebase.fromRawJson(String str) =>
      MessagesModelFirebase.fromJson(json.decode(str));

  factory MessagesModelFirebase.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFirebaseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesModelFirebaseToJson(this);

  @override
  MessagesEntityFirebase toEntity() {
    return MessagesEntityFirebase(
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
