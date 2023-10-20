import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class OperationNotAllowedError extends FirebaseError {
  OperationNotAllowedError() : super(translate('op_not_allowed'));
}
