import '../../../../core/models/base_entity.dart';
import '../../ads/entity/ads_entity.dart';
import '../../profile/entity/profile_entity.dart';


class OtherProfileEntity extends BaseEntity {
  final List<ItemsAdsEntity>? active_ads;
  final ItemsUserEntity? user;
  final List<ItemsUserEntity>? user_followers;
  final List<ItemsUserEntity>? user_followings;
   bool? is_follow;
   bool? is_blocked;
   String? sharing_link;



  OtherProfileEntity({
    this.active_ads,
    this.user,
    this.user_followings,
    this.user_followers,
    this.is_follow,
    this.is_blocked,
    this.sharing_link,
  });

  @override
  List<Object?> get props => [
    this.is_follow,
    this.user,
    this.user_followers,
    this.active_ads,
    this.user_followings,
    this.is_blocked,
    this.sharing_link,
  ];


}









