import '../../../../core/bloc/states/base_states.dart';
import '../../../../core/bloc/states/base_wait_state.dart';

class VersionState {
  GeneralState serverVersion;
  String currentVersion;

  VersionState({required this.serverVersion, required this.currentVersion});

  /// it is also init state
  factory VersionState.loadingAll() {
    return VersionState(serverVersion: BaseLoadingState(), currentVersion: '');
  }

  VersionState copyWith({
    GeneralState? serverVersion,
    String? currentVersion,
  }) {
    return VersionState(
      serverVersion: serverVersion ?? this.serverVersion,
      currentVersion: currentVersion ?? this.currentVersion,
    );
  }
}
