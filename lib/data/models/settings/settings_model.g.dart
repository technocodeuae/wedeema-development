// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsSettingsModel _$ItemsSettingsModelFromJson(Map<String, dynamic> json) =>
    ItemsSettingsModel(
      id: int.parse(json['id']??'0') ,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ItemsSettingsModelToJson(ItemsSettingsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

FAQModel _$FAQModelFromJson(Map<String, dynamic> json) => FAQModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemsFaqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FAQModelToJson(FAQModel instance) => <String, dynamic>{
      'data': instance.data,
    };

ItemsFaqModel _$ItemsFaqModelFromJson(Map<String, dynamic> json) =>
    ItemsFaqModel(
      question: json['question'] as String?,
      id: json['id'] as int?,
      answer: json['answer'] as String?,
      faq_id: int.parse(json['faq_id']),
      language_id: int.parse(json['language_id'])  ,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ItemsFaqModelToJson(ItemsFaqModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language_id': instance.language_id,
      'faq_id': instance.faq_id,
      'question': instance.question,
      'answer': instance.answer,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
