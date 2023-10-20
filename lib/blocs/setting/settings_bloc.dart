import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/profile/states/profile_state.dart';
import 'package:wadeema/blocs/setting/states/settings_state.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/profile/profile_repo_i.dart';
import '../../repos/settings/settings_repo_i.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsFacade settingsRepo;

  SettingsCubit(
    this.settingsRepo,
  ) : super(SettingsState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }




  Future<void> getShareLink(String url) async {
    emit(state.copyWith(getShareLinkState: BaseLoadingState()));
    final result = await settingsRepo.getShareLink(url);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getShareLinkState:
          GetShareLinkStateSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getShareLinkState: BaseFailState(
            result.error,
            callback: () => this.getShareLink(url),
          ),
        ),
      );
    }
  }
  
  Future<void> getAboutApp() async {
    emit(state.copyWith(getAboutAppState: BaseLoadingState()));
    final result = await settingsRepo.getAboutApp();
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getAboutAppState:
          GetAboutAppStateSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAboutAppState: BaseFailState(
            result.error,
            callback: () => this.getAboutApp(),
          ),
        ),
      );
    }
  }
  
  Future<void> getPrivacyPolicy() async {
    emit(state.copyWith(getPrivacyPolicyState: BaseLoadingState()));
    final result = await settingsRepo.getPrivacyPolicy();
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getPrivacyPolicyState:
          GetPrivacyPolicyStateSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getPrivacyPolicyState: BaseFailState(
            result.error,
            callback: () => this.getPrivacyPolicy(),
          ),
        ),
      );
    }
  }
  Future<void> getTerms() async {
    emit(state.copyWith(getTermsState: BaseLoadingState()));
    final result = await settingsRepo.getTerms();
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getTermsState:
          GetTermsStateSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getTermsState: BaseFailState(
            result.error,
            callback: () => this.getTerms(),
          ),
        ),
      );
    }
  }
  Future<void> getFAQ(int page) async {
    emit(state.copyWith(getFAQState: BaseLoadingState()));
    final result = await settingsRepo.getFAQ(page);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getFAQState:
          GetFAQStateSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getFAQState: BaseFailState(
            result.error,
            callback: () => this.getFAQ(page),
          ),
        ),
      );
    }
  }

}
