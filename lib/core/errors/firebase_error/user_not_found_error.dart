import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class UserNotFoundError extends FirebaseError {
  UserNotFoundError() : super(translate('user_not_found'));
}
