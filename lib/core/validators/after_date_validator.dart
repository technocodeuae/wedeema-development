import '../../../../core/utils/localization/app_localizations.dart';

import 'base_validator.dart';

class AfterDateValidator extends BaseValidator {
  final DateTime? dateBefore;

  AfterDateValidator({required this.dateBefore});

  @override
  String getMessage() {
    return '${translate('v_after_date')} ${dateBefore!.toIso8601String().substring(0, 10)}';
  }

  @override
  bool validate(String? value) {
    if (dateBefore == null) return true;
    if (value == null) return false;
    return DateTime.tryParse(value)?.isAfter(dateBefore!)??false;
  }
}
