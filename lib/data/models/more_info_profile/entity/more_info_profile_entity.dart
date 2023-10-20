import '../../../../core/models/base_entity.dart';
import '../../ads/entity/ads_entity.dart';
import '../../profile/entity/profile_entity.dart';


class MoreInfoProfileEntity extends BaseEntity {

  final ItemsUserEntity? user;
  final List<ItemsAdsEntity>? active_ads;
  final List<ItemsAdsEntity>? pending_ads;
  final List<ItemsAdsEntity>? favorite_ads;
  final List<ItemsUserEntity>? user_followers;
  final List<ItemsUserEntity>? user_followings;
  final List<ItemsUserEntity>? blocked_users;



  MoreInfoProfileEntity({
    this.user_followers,
    this.active_ads,
    this.user,
    this.blocked_users,
    this.favorite_ads,
    this.pending_ads,
    this.user_followings,
  });

  @override
  List<Object?> get props => [
    this.user_followers,
    this.active_ads,
    this.user,
    this.blocked_users,
    this.favorite_ads,
    this.pending_ads,
    this.user_followings,
  ];


}









