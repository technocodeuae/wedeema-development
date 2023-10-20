import '../../../../core/models/base_entity.dart';
import '../../../../core/models/base_models.dart';

class StringMultiLang extends BaseModel {
  String? value;
  String? arValue;
  String? enValue;

  StringMultiLang({this.arValue, this.enValue});

  factory StringMultiLang.fromJson(Map<String, String> json) {
    return StringMultiLang(
      arValue: json["arValue"],
      enValue: json["enValue"],
    );
  }

  Map<String, String?> toJson() {
    return {
      "arValue": arValue,
      "enValue": enValue,
    };
  }

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
