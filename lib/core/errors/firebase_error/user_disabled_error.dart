import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class UserDisabledError extends FirebaseError {
  UserDisabledError() : super(translate('user_disabled'));
}
