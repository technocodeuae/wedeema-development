import '../../../../core/models/base_entity.dart';


class SponsorsEntity extends BaseEntity {
  final int? id;
  final String? name;
  final String? image;
  final String? url;
  final String? mobile;
  final dynamic description;
  final dynamic created_by;
  final int? is_active;
  final DateTime? created_at;
  final DateTime? updated_at;


  SponsorsEntity({
    this.id,
    this.name,
    this.image,
    this.url,
    this.mobile,
    this.description,
    this.updated_at,
    this.created_at,
    this.is_active,
    this.created_by,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.name,
    this.image,
    this.url,
    this.mobile,
    this.description,
    this.created_by,
    this.is_active,
    this.created_at,
    this.updated_at,
  ];


}







