import '../../../../core/models/base_entity.dart';

class MessagesAllDataFirebaseEntity extends BaseEntity {
  MessagesAllDataFirebaseEntity({this.messages});

  final List<MessagesEntityFirebase>? messages;

  @override
  List<Object?> get props => [this.messages];
}

class MessagesEntityFirebase extends BaseEntity {
  MessagesEntityFirebase(
      {this.id,
      this.ad_id,
      this.ad_created_at,
      this.message,
      this.channel,
      this.user_name_2,
      this.user_name_1,
      this.user_id_2,
      this.user_id_1,
      this.ad_name,
      this.ad_img,
      this.created_at,
      this.updated_at,
      this.profile_pic,
      this.type,
      this.filename,
      this.filepath});

  final int? id;
  final dynamic user_id_1;
  final dynamic user_id_2;
  final dynamic ad_id;
  final String? message;
  final String? type;
  final String? filename;
  final String? filepath;
  final String? profile_pic;
  final int? channel;
  final DateTime? created_at;
  final DateTime? updated_at;
  final String? user_name_1;
  final dynamic user_name_2;
  final String? ad_name;
  final String? ad_img;
  final DateTime? ad_created_at;

  @override
  List<Object?> get props => [
        this.id,
        this.ad_id,
        this.ad_created_at,
        this.message,
        this.channel,
        this.profile_pic,
        this.user_name_2,
        this.user_name_1,
        this.user_id_2,
        this.user_id_1,
        this.ad_name,
        this.ad_img,
        this.created_at,
        this.updated_at,
        this.type,
        this.filename,
        this.filepath
      ];
}
