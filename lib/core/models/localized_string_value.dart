import '../../../../core/constants/app_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/utils/app_general_utils.dart';

class LocalizedStringValue extends BaseEntity {
  @override
  List<Object?> get props => [];

  String get value {
    return AppUtils.localize(whenArabic: arValue, whenEnglish: enValue) ?? '';
  }

  @override
  String toString() {
    return 'LocalizedStringValue {arValue: $arValue, '
        'enValue: $enValue, '
        '}';
  }

  String? get anyValue {
    switch (DIManager.findAC().appLanguage.languageCode) {
      case AppConsts.LANG_EN:
        if (enValue?.isNotEmpty == true) return enValue;
        return arValue;
      case AppConsts.LANG_AR:
        if (arValue?.isNotEmpty == true) return arValue;
        return enValue;
    }
    return null;
  }

  final String? arValue;
  final String? enValue;

  const LocalizedStringValue(this.arValue, this.enValue);

  /// Expects json model like:
  /// {
  ///   "ar": "مرحبا",
  ///   "en": "hello"
  /// }
  factory LocalizedStringValue.fromJson(Map<String, dynamic> json) {
    return LocalizedStringValue(json['arValue'], json['enValue']);
  }

  Map<String, dynamic> toJson() => {
        "arValue": arValue == null ? null : arValue,
        "enValue": enValue == null ? null : enValue,
      };
}
