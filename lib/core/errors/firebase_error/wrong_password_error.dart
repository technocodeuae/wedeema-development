import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class WrongPasswordError extends FirebaseError {
  WrongPasswordError() : super(translate('wrong_password'));
}
