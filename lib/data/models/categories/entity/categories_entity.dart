import '../../../../core/models/base_entity.dart';


class CategoriesEntity extends BaseEntity {
  final int? id;
  final int? parent_id;
  final int? sort_order;
  final String? filter_show;
  final String? slider_show;
  final dynamic icon;
  final dynamic head_img;
  final String? status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final int? hasChild;
  final int? category_id;
  final int? language_id;
  final String? title;


  CategoriesEntity({
    this.id,
    this.parent_id,
    this.sort_order,
    this.filter_show,
    this.slider_show,
    this.icon,
    this.head_img,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.hasChild,
    this.language_id,
    this.title,
    this.category_id,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.parent_id,
    this.sort_order,
    this.filter_show,
    this.slider_show,
    this.icon,
    this.head_img,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.hasChild,
    this.language_id,
    this.category_id,
    this.title,
  ];


}







