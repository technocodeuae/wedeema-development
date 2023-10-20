import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import '../profile/profile_model.dart';
import 'entity/list_user_entity.dart';

part 'list_user_model.g.dart';

@JsonSerializable()
class ListUserModel extends BaseModel {

  final List<ItemsUserModel>? data;

  ListUserModel({

    this.data,
  });

  factory ListUserModel.fromRawJson(String str) =>
      ListUserModel.fromJson(json.decode(str));

  factory ListUserModel.fromJson(Map<String, dynamic> json) =>
      _$ListUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListUserModelToJson(this);

  @override
  ListUserEntity toEntity() {
    return ListUserEntity(

      data: data?.map((e) => e.toEntity()).toList(),
    );
  }
}
