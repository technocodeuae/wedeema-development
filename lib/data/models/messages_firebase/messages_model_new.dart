class DataMassageModel {
  String? text;
  String? receiverId;
  String? senderId;
  DateTime? dateTime;

  /*
    dataMassage
    {
          'text': 'Hello',
          'senderId': '1234',
          'receiverId': '4321',
          'dateTime': '2023/11/7'
        }
     */

  DataMassageModel({
    required this.text,
    required this.receiverId,
    required this.senderId,
    required this.dateTime,
  });

  DataMassageModel.forJson(Map<String, dynamic> json) {
    text = json['text'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'receiverId': receiverId,
      'senderId': senderId,
      'dateTime': dateTime,
    };
  }
}
