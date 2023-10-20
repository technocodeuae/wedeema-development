import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class NotValidEmailError extends FirebaseError {
  NotValidEmailError() : super(translate('not_valid_email'));
}
