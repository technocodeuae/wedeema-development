import '../../../../core/models/base_entity.dart';


class CitiesEntity extends BaseEntity {
  final int? id;
  final String? title;
  final String? status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final DateTime? deleted_at;


  CitiesEntity({
    this.id,
    this.title,
    this.status,
    this.deleted_at,
    this.updated_at,
    this.created_at,

  });

  @override
  List<Object?> get props => [
    this.id,
    this.title,
    this.deleted_at,
    this.status,
    this.created_at,
    this.updated_at,
  ];


}







