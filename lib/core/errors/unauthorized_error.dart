import '../../../../core/utils/localization/app_localizations.dart';

import './base_error.dart';

class UnauthorizedError extends BaseError {
  UnauthorizedError({String? message})
      : super(message ?? translate('unauthorized_err'));
}
