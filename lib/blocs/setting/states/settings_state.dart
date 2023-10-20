
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/auth/entity/auth_entity.dart';
import '../../../data/models/settings/entity/settings_entity.dart';
import '../../../data/models/share_link/entity/share_link_entity.dart';

class SettingsState {

  GeneralState getShareLinkState;
  GeneralState getAboutAppState;
  GeneralState getPrivacyPolicyState;
  GeneralState getTermsState;
  GeneralState getFAQState;



  SettingsState({
    required this.getShareLinkState,
    required this.getAboutAppState,
    required this.getPrivacyPolicyState,
    required this.getTermsState,
    required this.getFAQState,
  });

  factory SettingsState.initialState() => SettingsState(

    getShareLinkState: BaseInitState(),
    getTermsState: BaseInitState(),
    getPrivacyPolicyState: BaseInitState(),
    getAboutAppState: BaseInitState(),
    getFAQState: BaseInitState(),



  );

  SettingsState copyWith({

    GeneralState? getShareLinkState,
    GeneralState? getTermsState,
    GeneralState? getPrivacyPolicyState,
    GeneralState? getAboutAppState,
    GeneralState? getFAQState,


  }) {
    return SettingsState(

    getShareLinkState: getShareLinkState ?? this.getShareLinkState,
    getAboutAppState: getAboutAppState ?? this.getAboutAppState,
    getPrivacyPolicyState: getPrivacyPolicyState ?? this.getPrivacyPolicyState,
    getTermsState: getTermsState ?? this.getTermsState,
    getFAQState: getFAQState ?? this.getFAQState,



    );
  }
}



class GetShareLinkStateSuccessState extends BaseSuccessState {
  final ShareLinkEntity shareLink;

  GetShareLinkStateSuccessState(this.shareLink);
}
class GetAboutAppStateSuccessState extends BaseSuccessState {
  final ItemsSettingsEntity aboutApp;

  GetAboutAppStateSuccessState(this.aboutApp);
}
class GetPrivacyPolicyStateSuccessState extends BaseSuccessState {
  final ItemsSettingsEntity privacyPolicy;

  GetPrivacyPolicyStateSuccessState(this.privacyPolicy);
}
class GetTermsStateSuccessState extends BaseSuccessState {
  final ItemsSettingsEntity terms;

  GetTermsStateSuccessState(this.terms);
}

class GetFAQStateSuccessState extends BaseSuccessState {
  final FAQEntity faq;

  GetFAQStateSuccessState(this.faq);
}




