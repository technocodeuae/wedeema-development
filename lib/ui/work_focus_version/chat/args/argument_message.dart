import 'dart:io';

class ArgumentMessage {
  final String? message;
  final String? nameAds;
  final String? imageAds;
  final String? nameOwnerAds;
  final String? user_name_person_sender;
  final String? ad_id_firebase;
  final String? user_id;
  final int? user_id_2;
  final bool? adsIsJob;

  final int? ad_id;
  final List<File>? files;

  ArgumentMessage({
    this.message,
    this.user_id_2,
    this.ad_id,
    this.ad_id_firebase,
    this.adsIsJob,
    this.user_id,
    this.files,
    this.nameAds,
    this.user_name_person_sender,
    this.imageAds,
    this.nameOwnerAds,
  });
}
