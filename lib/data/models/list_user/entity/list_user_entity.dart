import '../../../../core/models/base_entity.dart';
import '../../ads/entity/ads_entity.dart';
import '../../profile/entity/profile_entity.dart';


class ListUserEntity extends BaseEntity {

  final List<ItemsUserEntity>? data;




  ListUserEntity({
    this.data,

  });

  @override
  List<Object?> get props => [

    this.data,
  ];


}









