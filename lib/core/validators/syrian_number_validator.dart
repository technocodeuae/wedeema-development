import '../../../../core/utils/localization/app_localizations.dart';

import '../validators/base_validator.dart';

class SyrianNumberValidator extends BaseValidator {
  @override
  String getMessage() {
    return translate('v_invalid_number');
  }

  @override
  bool validate(String? value) {
    return value != null &&
        value.isNotEmpty &&
        (value.startsWith('09') && value.length == 10);

    /// TODO: Implement For UAE
  }
}
