import 'package:get_storage/get_storage.dart';
import 'package:wadeema/blocs/evaluate/evaluate_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';

import '../../../../core/utils/sharing_utils/sharing_utils.dart';
import '../../../../data/sources/auth/auth_remote_data_source.dart';

import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/ads/ads_bloc.dart';
import '../../blocs/application/application_bloc.dart';


import '../../blocs/auth/auth_bloc.dart';

import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/notifications/notifications_bloc.dart';
import '../../blocs/cities/cities_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/update_profile_bloc.dart';
import '../../blocs/setting/settings_bloc.dart';
import '../../blocs/sponsors/sponsors_bloc.dart';
import '../../blocs/upload_ads/upload_ads_bloc.dart';
import '../../data/sources/ads/ads_remote_data_source.dart';
import '../../data/sources/categories/categories_remote_data_source.dart';
import '../../data/sources/chat/chat_remote_data_source.dart';
import '../../data/sources/cities/cities_remote_data_source.dart';
import '../../data/sources/evaluate/evaluate_remote_data_source.dart';
import '../../data/sources/notifications/notifications_remote_data_source.dart';
import '../../data/sources/profile/profile_remote_data_source.dart';
import '../../data/sources/settings/settings_remote_data_source.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import '../../data/sources/upload_ads/ads_remote_data_source.dart';
import '../../repos/notifications/notifications_repo_i.dart';
import '../../repos/ads/ads_repo_i.dart';
import '../../repos/ads/impl_ads_repo.dart';
import '../../repos/auth/auth_repo_i.dart';
import '../../repos/auth/impl_auth_repo.dart';
import '../../repos/categories/categories_repo_i.dart';
import '../../repos/categories/impl_categories_repo.dart';
import '../../repos/chat/chat_repo_i.dart';
import '../../repos/chat/impl_chat_repo.dart';
import '../../repos/cities/cities_repo_i.dart';
import '../../repos/cities/impl_cities_repo.dart';
import '../../repos/evaluate/evaluate_repo_i.dart';
import '../../repos/evaluate/impl_evaluate_repo.dart';
import '../../repos/notifications/impl_notifications_repo.dart';
import '../../repos/profile/impl_profile_repo.dart';
import '../../repos/profile/profile_repo_i.dart';
import '../../repos/settings/impl_settings_repo.dart';
import '../../repos/settings/settings_repo_i.dart';
import '../../repos/sponsors/impl_sponsors_repo.dart';
import '../../repos/sponsors/sponsors_repo_i.dart';
import '../../repos/upload_ads/impl_upload_ads_repo.dart';
import '../../repos/upload_ads/upload_ads_repo_i.dart';
import 'module/local_module.dart';
import 'module/network_module.dart';
import 'module/rest_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DIManager {
  DIManager._();

  static Future<void> initDI() async {
    _injectDep(
      AppNavigator(),
    );

    /// Shared Prefs
    await _setupSharedPreference();
    _injectDepLazy(
      SharingUtils(),
    );
    _injectDep(
      ApplicationCubit(),
    );
    _injectDep(
      AppColorsController(),
    );
    _injectDep(
      RestClient(),
    );



    _injectDep(
      NetworkModule.provideDio(
        findDep<SharedPrefs>(),
        findDep<RestClient>(),
      ),
    );
    await _injectDepLazyAsync<Database>(await LocalModule.provideDatabase());




    /// Utils
    // _injectDepLazy(
    //   AttachmentsUtils(),
    // );
    _injectDepLazy(
      Uuid(),
    );

    /// REPOs

    // _injectDepLazy(
    //   DepartmentRepo(_injectDep(DepartmentRemoteDataSource())),
    // );
    // _injectDepLazy(
    //   AttachmentsRepo(),
    // );

    final db = await findDepAsync<Database>();

    /// Remotes --------------------------------------------------------------


     /// Auth'  Remotes
    _injectDepLazy<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
     /// Sponsors'  Remotes
    _injectDepLazy<SponsorsRemoteDataSource>(SponsorsRemoteDataSourceImpl());
    /// Ads'  Remotes
    _injectDepLazy<AdsRemoteDataSource>(AdsRemoteDataSourceImpl());


    /// Settings'  Remotes
    _injectDepLazy<SettingsRemoteDataSource>(SettingsRemoteDataSourceImpl());

    ///Upload Ads'  Remotes
    _injectDepLazy<UploadAdsRemoteDataSource>(UploadAdsRemoteDataSourceImpl());
    /// Categories'  Remotes
    _injectDepLazy<CategoriesRemoteDataSource>(CategoriesRemoteDataSourceImpl());
    /// Cities'  Remotes
    _injectDepLazy<CitiesRemoteDataSource>(CitiesRemoteDataSourceImpl());

    /// Profile'  Remotes
    _injectDepLazy<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl());


    /// Evaluate'  Remotes
    _injectDepLazy<EvaluateRemoteDataSource>(EvaluateRemoteDataSourceImpl());

    /// Chat'  Remotes
    _injectDepLazy<ChatRemoteDataSource>(ChatRemoteDataSourceImpl());

    /// Notifications' Remotes
    _injectDepLazy<NotificationsRemoteDataSource>(NotificationsRemoteDataSourceImpl());





    /// Repos --------------------------------------------------------------



    /// Auth' Repo
    _injectDepLazy<AuthFacade>(
      AuthRepo(
        findDep(),
        findDep(),
      ),
    );


    /// Sponsors' Repo
    _injectDepLazy<SponsorsFacade>(
      SponsorsRepo(
        findDep(),
        findDep(),
      ),
    );


    /// Ads' Repo
    _injectDepLazy<AdsFacade>(
      AdsRepo(
        findDep(),
        findDep(),
      ),
    );

    /// Upload Ads' Repo
    _injectDepLazy<UploadAdsFacade>(
      UploadAdsRepo(
        findDep(),
        findDep(),
      ),
    );


    /// Categories' Repo
    _injectDepLazy<CategoriesFacade>(
      CategoriesRepo(
        findDep(),
        findDep(),
      ),
    );

    /// Cities' Repo
    _injectDepLazy<CitiesFacade>(
      CitiesRepo(
        findDep(),
        findDep(),
      ),
    );


    /// Profile' Repo
    _injectDepLazy<ProfileFacade>(
      ProfileRepo(
        findDep(),
        findDep(),
      ),
    );

    /// Settings' Repo
    _injectDepLazy<SettingsFacade>(
      SettingsRepo(
        findDep(),
        findDep(),
      ),
    );


    /// Evaluate' Repo
    _injectDepLazy<EvaluateFacade>(
      EvaluateRepo(
        findDep(),
        findDep(),
      ),
    );



    /// Chat' Repo
    _injectDepLazy<ChatFacade>(
      ChatRepo(
        findDep(),
        findDep(),
      ),
    );



    /// Notifications' Repo
    _injectDepLazy<NotificationsFacade>(
      NotificationsRepo(
        findDep(),
        findDep(),
      ),
    );

    //
    //
    // _injectDepLazy<PostRepoFacade>(
    //   ImplPostRepo(
    //     // _injectDep(PostLocalDataSourceImpl(db)),
    //     _injectDep<PostRemoteDataSource>(PostRemoteDataSourceImpl()),
    //     // findDep(),
    //   ),
    // );

    // _injectDepLazy(
    //   NotificationRepo(_injectDep(RemoteNotificationDataSourceImpl())),
    // );
    //
    // _injectDepLazy(
    //   EvaluationRepo(_injectDep(EvaluationRemoteSourceImpl())),
    // );
    // _injectDepLazy<TaskManagementRepoFacade>(
    //   TaskManagementRepo(
    //     findDep(),
    //   ),
    // );

    /// BLOCs

    /// Auth' Blocs
    _injectDep(
      AuthCubit(findDep<AuthFacade>()),
    );

    /// Sponsors' Blocs
    _injectDep(
      SponsorsCubit(findDep<SponsorsFacade>()),
    );


    /// Ads' Blocs
    _injectDep(
      AdsCubit(findDep<AdsFacade>()),
    );



    ///Upload Ads' Blocs
    _injectDep(
      UploadAdsCubit(findDep<UploadAdsFacade>()),
    );


    /// Notifications' Blocs
    _injectDep(
      NotificationsCubit(findDep<NotificationsFacade>()),
    );

    /// Chat' Blocs
    _injectDep(
      ChatCubit(findDep<ChatFacade>()),
    );


    /// Categories' Blocs
    _injectDep(
      CategoriesCubit(findDep<CategoriesFacade>()),
    );


    /// Cities' Blocs
    _injectDep(
      CitiesCubit(findDep<CitiesFacade>()),
    );


    /// Settings' Blocs
    _injectDep(
      SettingsCubit(findDep<SettingsFacade>()),
    );

    /// Profile' Blocs
    _injectDep(
      ProfileCubit(findDep<ProfileFacade>()),
    );

    /// Update Profile' Blocs
    _injectDep(
      UpdateProfileCubit(findDep<ProfileFacade>()),
    );

    /// Evaluate' Blocs
    _injectDep(
      EvaluateCubit(findDep<EvaluateFacade>()),
    );
    // _injectDep(
    //   LocalAuthBiometricCubit(),
    // );
    //

  }

  static T _injectDep<T extends Object>(T dependency) {
    getIt.registerSingleton<T>(dependency);
    return getIt<T>();
  }

  static void _injectDepLazy<T extends Object>(T dependency) {
    getIt.registerLazySingleton<T>(() => dependency);
  }

  static Future<void> _injectDepLazyAsync<T extends Object>(
    T dependency,
  ) async {
    getIt.registerLazySingletonAsync<T>(() async => dependency);
    return null;
  }

  static T findDep<T extends Object>() {
    return getIt<T>();
  }

  static Future<T> findDepAsync<T extends Object>() async {
    return getIt.getAsync<T>();
  }

  static AppNavigator findNavigator() {
    return findDep<AppNavigator>();
  }

  /// It's helper method to retrieve the [AppColorsController] Class
  /// And  {*findCC} equals to FindColorsController
  static AppColorsController findCC() {
    return findDep<AppColorsController>();
  }

  /// It's helper method to retrieve the [ApplicationCubit] Class
  /// And  {*findAC} equals to FindApplicationCubit
  static ApplicationCubit findAC() {
    return findDep<ApplicationCubit>();
  }

  static _setupSharedPreference() async {
    await GetStorage.init();
    _injectDep(SharedPrefs());
  }

  static dispose() {
    findDep<ApplicationCubit>().close();

  }
}
