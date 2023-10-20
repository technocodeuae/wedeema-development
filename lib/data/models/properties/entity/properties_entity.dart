import '../../../../core/models/base_entity.dart';


class PropertiesEntity extends BaseEntity {
  final ItemsPropertiesEntity? property;
  final List<ItemsSubPropertiesEntity>? sub_properties;

  PropertiesEntity({
    this.property,
    this.sub_properties,

  });

  @override
  List<Object?> get props => [
    this.sub_properties,
    this.property,

  ];


}


class ItemsPropertiesEntity extends BaseEntity {
  ItemsPropertiesEntity({
    this.id,
    this.categoryId,
    this.hasChild,
    this.title,
    this.updatedAt,
    this.createdAt,
    this.parentId,
    this.status,
    this.languageId,
    this.deletedAt,
    this.sortOrder,
    this.essential,
    this.type,
    this.propertyId,

  });

  final int? id;
  final String? status;
  final dynamic parentId;
  final int? sortOrder;
  final int? hasChild;
  final String? essential;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? categoryId;
  final int? propertyId;
  final int? languageId;
  final String? title;

  @override
  List<Object?> get props => [
    this.id,
    this.categoryId,
    this.hasChild,
    this.title,
    this.updatedAt,
    this.createdAt,
    this.parentId,
    this.status,
    this.languageId,
    this.deletedAt,
    this.sortOrder,
    this.essential,
    this.type,
    this.propertyId,

  ];

}

class ItemsSubPropertiesEntity extends BaseEntity {
  ItemsSubPropertiesEntity({
    this.id,
   this.propertyId,
    this.title,
    this.updatedAt,
    this.createdAt,
    this.status,
    this.languageId,
    this.deletedAt,
    this.subpropertyId,

  });

  final int? id;
  final int? propertyId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? subpropertyId;
  final int? languageId;
  final String? title;

  @override
  List<Object?> get props => [
    this.id,
    this.propertyId,
    this.title,
    this.updatedAt,
    this.createdAt,
    this.status,
    this.languageId,
    this.deletedAt,
    this.subpropertyId,
  ];

}







