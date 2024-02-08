import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/app_bar_app.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/app_general_utils.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/dialogs/custom_dialogs.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../auth/pages/sign_in_page.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../settings/pages/about_app_page.dart';
import '../../settings/pages/account_settings_pages.dart';
import '../../settings/pages/faq_page.dart';
import '../../settings/pages/privacy_policy_page.dart';
import '../../settings/pages/terms_and_conditions_page.dart';
import '../widget/item_profile_card_widget.dart';
import 'my_account_page.dart';

class MyProfilePage extends StatefulWidget {
  static const routeName = '/MyProfilePage';

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }
  bool _isLoading = false;
  bool _isLoadingDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarApp(context, text: translate("menu"),),
      bottomNavigationBar: bottomNavigationBarWidget(indexPage: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (DIManager.findDep<SharedPrefs>().getToken() == null ||
                    DIManager.findDep<SharedPrefs>().getToken()!.isEmpty)
                ? Container()
                : ItemProfileCardWidget(
                    isProfile: true,
                    title: translate("profile"),
                    icon: AppAssets.accountIcons,
                    onPressed: () {
                      if (!AppUtils.checkIfGuest(context)) {
                        DIManager.findNavigator().pushNamed(
                          MyAccountPage.routeName,
                        );
                      }
                    }),
            ItemProfileCardWidget(
                title: translate("account_settings"),
                icon: AppAssets.settingIcon,
                onPressed: () {
                    DIManager.findNavigator().pushNamed(
                      AccountSettingsPage.routeName,
                    );
                }),
            ItemProfileCardWidget(
                title: translate("set_lang"),
                icon: AppAssets.languageIcon,
                onPressed: () async {
                  CustomDialogs.showSortBottomSheet(
                      ['العربية', 'English'], onChange: (value) {
                    if (value == 'English') {
                      DIManager.findDep<ApplicationCubit>()
                          .changeLanguage(AppConsts.LANG_EN);
                    } else {
                      DIManager.findDep<ApplicationCubit>()
                          .changeLanguage(AppConsts.LANG_AR);
                    }
                    setState(() {});
                  },
                      value: AppUtils.localize(
                          whenArabic: 'العربية', whenEnglish: 'English'),
                      title: translate('language'));
                }),
            ItemProfileCardWidget(
                title: translate("terms"),
                icon: AppAssets.termsAndConditionIcon,
                onPressed: () {
                  DIManager.findNavigator().pushNamed(
                    TermsPage.routeName,
                  );
                }),
            ItemProfileCardWidget(
                title: translate("privacy"),
                icon: AppAssets.privacyPolicyIcon,
                onPressed: () {
                  DIManager.findNavigator().pushNamed(
                    PrivacyPolicyPage.routeName,
                  );
                }),
            ItemProfileCardWidget(
                title: translate("faq"),
                icon: AppAssets.faqIcon,
                onPressed: () {
                  DIManager.findNavigator().pushNamed(
                    FAQPage.routeName,
                  );
                }),
            ItemProfileCardWidget(
                title: translate("about_app"),
                icon: AppAssets.aboutAppIcon,
                onPressed: () {
                  DIManager.findNavigator().pushNamed(
                    AboutAppPage.routeName,
                  );
                }),
            (DIManager.findDep<SharedPrefs>().getToken() != null &&
                    DIManager.findDep<SharedPrefs>()
                        .getToken()!
                        .isNotEmpty)
                ? BlocListener<AuthCubit, AuthState>(
                    bloc: DIManager.findDep<AuthCubit>(),
                    listener: (_, state) {
                      final registerState = state.logout;
                      final deleteAccountState = state.deletAccount;
                      if (_isLoading == true &&registerState is BaseFailState) {
                        setState(() {
                          _isLoading = false;
                        });
                        CustomSnackbar.showErrorSnackbar(
                          registerState.error!,
                        );
                        DIManager.findNavigator().pushNamedAndRemoveUntil(
                          SignInPage.routeName,
                        );
                      }
                      if (_isLoading == true && registerState is LogOutSuccessState) {
                        setState(() {
                          _isLoading = false;
                        });
                        DIManager.findNavigator().pushNamedAndRemoveUntil(
                          SignInPage.routeName,
                        );
                      }
                      if (_isLoadingDelete == true && deleteAccountState is DeleteAccountSuccessState) {
                        setState(() {
                          _isLoadingDelete = false;
                        });
                        DIManager.findNavigator().pushNamedAndRemoveUntil(
                          SignInPage.routeName,
                        );
                      }
                    },
                    child:  ItemProfileCardWidget(
                      isLoading: _isLoading,
                      title: translate("sign_out"),
                      icon: AppAssets.logOutIcon,
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        if (!AppUtils.checkIfGuest(context)) {
                          DIManager.findDep<AuthCubit>().logout();
                        }
                      },
                    ),
                  )
                : ItemProfileCardWidget(
                    title: translate("sign_in"),
                    icon: AppAssets.enterIcons,
                    onPressed: () {
                      DIManager.findNavigator().pushNamedAndRemoveUntil(
                        SignInPage.routeName,
                      );
                    },
                  ),
            (DIManager.findDep<SharedPrefs>().getToken() != null &&
                DIManager.findDep<SharedPrefs>()
                    .getToken()!
                    .isNotEmpty)
                ? BlocListener<AuthCubit, AuthState>(
              bloc: DIManager.findDep<AuthCubit>(),
              listener: (_, state) {
                final registerState = state.logout;
                if (_isLoading == true &&registerState is BaseFailState) {
                  setState(() {
                    _isLoading = false;
                  });
                  CustomSnackbar.showErrorSnackbar(
                    registerState.error!,
                  );
                  DIManager.findNavigator().pushNamedAndRemoveUntil(
                    SignInPage.routeName,
                  );
                }
                if (_isLoading == true && registerState is LogOutSuccessState) {
                  setState(() {
                    _isLoading = false;
                  });
                  DIManager.findNavigator().pushNamedAndRemoveUntil(
                    SignInPage.routeName,
                  );
                }
              },
              child:  ItemProfileCardWidget(
                isLoading: _isLoadingDelete,
                title: translate("delete_account"),
                icon: AppAssets.deleteAccountIcons,
                onPressed: () {
                  setState(() {
                    _isLoadingDelete = true;
                  });
                  if (!AppUtils.checkIfGuest(context)) {
                    DIManager.findDep<AuthCubit>().deleteAccount();
                  }
                },
              ),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
      // bottomNavigationBar: bottomNavigationBarWidget(indexPage: 10),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class LangList {
  String name;
  int index;

  LangList({required this.name, required this.index});
}
