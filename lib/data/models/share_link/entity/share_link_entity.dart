import '../../../../core/models/base_entity.dart';
import '../../ads/entity/ads_entity.dart';
import '../../profile/entity/profile_entity.dart';


class ShareLinkEntity extends BaseEntity {
  final ItemsUserEntity? user;
  final ItemsAdsEntity? ad;



  ShareLinkEntity({

    this.user,
    this.ad,
  });

  @override
  List<Object?> get props => [
    this.ad,
    this.user

  ];


}











