import 'package:get/get.dart';
import '../../../../core/errors/base_error.dart';

class BaseGetController extends GetxController {
  // todo later : rebuild this class before linking

  Rx<BaseGetXState?> _state = Rx<BaseGetXState?>(null);

  void addStateListener(void Function(BaseGetXState? state) stateListener) {
    _state.listen(stateListener);
  }

  BaseGetXState? get state {
    return _state.value;
  }

  set state(BaseGetXState? value) {
    /// clear the error with the new state
    if (value != BaseGetXState.FAILURE) error = null;
    _state.value = value;
  }

  BaseError? error;
}

enum BaseGetXState { SUCCESS, LOADING, FAILURE }
