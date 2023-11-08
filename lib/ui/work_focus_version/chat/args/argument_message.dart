import 'dart:io';

class ArgumentMessage {
  final String? message;
  final String? nameAds;
  final String? imageAds;
  final String? nameOwnerAds;
  final int? user_id_2;

  final int? ad_id;
  final List<File>? files;

  ArgumentMessage({
    this.message,
    this.user_id_2,
    this.ad_id,
    this.files,
    this.nameAds,
    this.imageAds,
    this.nameOwnerAds,
  });
}
