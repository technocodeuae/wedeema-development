import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/validators/base_validator.dart';

class EmployeeIDValidator extends BaseValidator {
  @override
  String getMessage() {
    return translate('v_invalid_national_id');
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty && value.length == 11;

    /// "v_invalid_employee_id"
    /// TODO: Implement when connect to backend
  }
}
