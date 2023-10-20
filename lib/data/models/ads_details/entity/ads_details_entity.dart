import '../../../../core/models/base_entity.dart';
import '../../ads/entity/ads_entity.dart';


class AdsDetailsEntity extends BaseEntity {
  final ItemsAdsEntity? ad;
  final List<CategoryAdsDetailsEntity>? categories;
  final List<ImageAdsDetailsEntity>? images;
  final List<CategoryAdsDetailsEntity>? properties;
  final List<RatingAdsDetailsEntity>? ratings;
  final String? sharing_link;

  AdsDetailsEntity({
    this.ad,
    this.categories,
    this.images,
    this.properties,
    this.ratings,
    this.sharing_link,
  });

  @override
  List<Object?> get props => [
    this.ad,
    this.categories,
    this.images,
    this.properties,
    this.ratings,
    this.sharing_link,
  ];


}



class CategoryAdsDetailsEntity extends BaseEntity {
  CategoryAdsDetailsEntity({
    this.id,
    this.parent_id,
    this.sort_order,
    this.filter_show,
    this.slider_show,
    this.type,
    this.icon,
    this.head_img,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.has_child,
    this.category_id,
    this.language_id,
    this.title,
    this.ad_id,
    this.essential,
    this.property_id,
    this.subproperty_id,
    this.description,
  });

  final int? id;
  final int? parent_id;
  final int? sort_order;
  final String? filter_show;
  final String? slider_show;
  final String? type;
  final String? icon;
  final String? head_img;
  final String? status;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final int? has_child;
  final int? category_id;
  final int? language_id;
  final String? title;
  final int? ad_id;
  final String? essential;
  final int? property_id;
  final dynamic subproperty_id;
  final String? description;


  @override
  List<Object?> get props => [
    this.id,
    this.parent_id,
    this.sort_order,
    this.filter_show,
    this.slider_show,
    this.type,
    this.icon,
    this.head_img,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.has_child,
    this.category_id,
    this.language_id,
    this.title,
    this.ad_id,
    this.essential,
    this.property_id,
    this.subproperty_id,
    this.description,
  ];

}

class ImageAdsDetailsEntity extends BaseEntity {
  ImageAdsDetailsEntity({
    this.id,
    this.ad_id,
    this.featured,
    this.name,
    this.created_at,
    this.updated_at,
  });

  final int? id;
  final int? ad_id;
  final String? featured;
  final String? name;
  final DateTime? created_at;
  final DateTime? updated_at;


  @override
  List<Object?> get props => [
    this.id,
    this.ad_id,
    this.featured,
    this.name,
    this.created_at,
    this.updated_at,
  ];

}

class RatingAdsDetailsEntity extends BaseEntity {
  RatingAdsDetailsEntity({
    this.id,
    this.type,
    this.evaluator_id,
    this.evaluated_id,
    this.ad_id,
    this.value,
    this.comment,
    this.created_at,
    this.updated_at,
    this.user_name,
    this.user_profile_pic,
    this.user_id
  });

  final int? id;
  final String? type;
  final int? evaluator_id;
  final dynamic evaluated_id;
  final int? ad_id;
  final int? user_id;
  final dynamic value;
  final String? comment;
  final DateTime? created_at;
  final DateTime? updated_at;
  final String? user_name;
  final String? user_profile_pic;

  @override
  List<Object?> get props => [
    this.id,
    this.type,
    this.evaluator_id,
    this.evaluated_id,
    this.ad_id,
    this.value,
    this.comment,
    this.user_id,
    this.created_at,
    this.updated_at,
    this.user_name,
    this.user_profile_pic,
  ];

}







