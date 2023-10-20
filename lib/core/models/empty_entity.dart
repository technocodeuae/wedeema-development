import '../../../../core/models/base_entity.dart';

class EmptyEntity extends BaseEntity {
  final dynamic data;

  const EmptyEntity(this.data);

  @override
  List<Object?> get props => [data];
}
