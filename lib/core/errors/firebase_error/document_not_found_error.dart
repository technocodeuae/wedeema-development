import '../../../../core/errors/firebase_error/firebase_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class DocumentNotFoundError extends FirebaseError {
  DocumentNotFoundError() : super(translate('doc_not_found'));
}
