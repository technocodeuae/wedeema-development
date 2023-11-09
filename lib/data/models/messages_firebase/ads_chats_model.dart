class AdsChatsModel {
  String? massage;
  String? nameOwnerAds;
  String? userNamePersonSender;
  String? nameAds;
  String? ad_id;
  String? user_id;
  String? user_id_2;
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
    required this.massage,
    required this.nameOwnerAds,
    required this.nameAds,
    required this.userNamePersonSender,
    required this.ad_id,
    required this.user_id,
    required this.user_id_2,
    required this.imageAds,
    required this.dateTime,
  });

  AdsChatsModel.forJson(Map<String, dynamic> json) {
    massage = json['massage']as String;
    nameOwnerAds = json['nameOwnerAds']as String;
    user_id = json['user_id']as String;
    user_id_2 = json['user_id_2']as String;
    nameAds = json['nameAds'] as String;
    userNamePersonSender = json['userNamePersonSender'] as String;
    ad_id = json['ad_id'] as String;
    imageAds = json['imageAds'] as String;
    dateTime = json['dateTime'] as String;
  }

  Map<String, dynamic> toMap() {
    return {
      'massage': massage,
      'nameAds': nameAds,
      'nameOwnerAds': nameOwnerAds,
      'user_id': user_id,
      'user_id_2': user_id_2,
      'ad_id': ad_id,
      'imageAds': imageAds,
      'userNamePersonSender': userNamePersonSender,
      'dateTime': dateTime,
    };
  }
}
