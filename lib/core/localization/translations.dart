import 'package:get/get.dart';
import '../../../../core/localization/ar.dart';
import '../../../../core/localization/en.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
