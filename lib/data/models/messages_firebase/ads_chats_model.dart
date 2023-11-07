class AdsChatsModel {
  // String? text;
  String? nameAds;
  String? ad_id;
  String? imageAds;
  String? dateTime;

  /*
       dataAds
    {
           'nameAds':'سيارة نيسان',
           'lastText':'Hello',
           'ad_id':'1234',
           'imageAds':'as/asd/asd.png',
           'dateTime':'2023/11/7'
        }
     */

  AdsChatsModel({
    // required this.text,
    required this.nameAds,
    required this.ad_id,
    required this.imageAds,
    required this.dateTime,
  });

  AdsChatsModel.forJson(Map<String, dynamic> json) {
    // text = json['text'];
    nameAds = json['nameAds'];
    ad_id = json['ad_id'];
    imageAds = json['imageAds'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      // 'text': text,
      'nameAds': nameAds,
      'ad_id': ad_id,
      'imageAds': imageAds,
      'dateTime': dateTime,
    };
  }
}
