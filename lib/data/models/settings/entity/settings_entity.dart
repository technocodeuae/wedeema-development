import '../../../../core/models/base_entity.dart';





class ItemsSettingsEntity extends BaseEntity {
  ItemsSettingsEntity({
    this.id,
    this.title,

  });

  final int? id;
  final String? title;



  @override
  List<Object?> get props => [
    this.id,
    this.title,

  ];

}
class FAQEntity extends BaseEntity {
  FAQEntity({
    this.data,


  });

  final List<ItemsFaqEntity>? data;



  @override
  List<Object?> get props => [
    this.data,
  ];

}
class ItemsFaqEntity extends BaseEntity {
  ItemsFaqEntity({
    this.id,
    this.created_at,
    this.updated_at,
    this.language_id,
    this.answer,
    this.faq_id,
    this.question,
  });

  final int? id;
  final int? language_id;
  final int? faq_id;
  final String? question;
  final String? answer;
  final DateTime? created_at;
  final DateTime? updated_at;



  @override
  List<Object?> get props => [
    this.id,
    this.created_at,
    this.updated_at,
    this.language_id,
    this.answer,
    this.faq_id,
    this.question,
  ];

}









