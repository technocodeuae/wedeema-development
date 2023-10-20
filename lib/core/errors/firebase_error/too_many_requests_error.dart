import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class TooManyRequestError extends FirebaseError {
  TooManyRequestError() : super(translate('too_many_request'));
}
