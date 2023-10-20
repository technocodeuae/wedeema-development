import '../../../../core/bloc/states/base_success_state.dart';

class ServerVersionSuccessState extends BaseSuccessState {
  final bool isUpdatable;
  final bool isSupported;
  final String? latestVersion;
  final String? updateUrl;

  const ServerVersionSuccessState({
    required this.isUpdatable,
    required this.isSupported,
    required this.latestVersion,
    required this.updateUrl,
  });
}
