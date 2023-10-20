import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/base_models.dart';
import 'entity/settings_entity.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class ItemsSettingsModel extends BaseModel {
  final int? id;
  final String? title;

  ItemsSettingsModel({
    this.id,
    this.title,
  });

  factory ItemsSettingsModel.fromRawJson(String str) =>
      ItemsSettingsModel.fromJson(json.decode(str));

  factory ItemsSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsSettingsModelToJson(this);

  @override
  ItemsSettingsEntity toEntity() {
    return ItemsSettingsEntity(
      id: this.id,
      title: this.title,
    );
  }
}

@JsonSerializable()
class FAQModel extends BaseModel {
  final List<ItemsFaqModel>? data;

  FAQModel({
    this.data,
  });

  factory FAQModel.fromRawJson(String str) =>
      FAQModel.fromJson(json.decode(str));

  factory FAQModel.fromJson(Map<String, dynamic> json) =>
      _$FAQModelFromJson(json);

  Map<String, dynamic> toJson() => _$FAQModelToJson(this);

  @override
  FAQEntity toEntity() {
    return FAQEntity(
      data: this.data?.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ItemsFaqModel extends BaseModel {
  final int? id;
  final int? language_id;
  final int? faq_id;
  final String? question;
  final String? answer;
  final DateTime? created_at;
  final DateTime? updated_at;

  ItemsFaqModel({
    this.question,
    this.id,
    this.answer,
    this.faq_id,
    this.language_id,
    this.created_at,
    this.updated_at,
  });

  factory ItemsFaqModel.fromRawJson(String str) =>
      ItemsFaqModel.fromJson(json.decode(str));

  factory ItemsFaqModel.fromJson(Map<String, dynamic> json) =>
      _$ItemsFaqModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsFaqModelToJson(this);

  @override
  ItemsFaqEntity toEntity() {
    return ItemsFaqEntity(
      id: this.id,
      language_id: this.language_id,
      answer: this.answer,
      faq_id: this.faq_id,
      question: this.question,
      created_at: this.created_at,
      updated_at: this.updated_at,
    );
  }
}
