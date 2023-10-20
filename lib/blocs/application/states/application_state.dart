import '../../../../blocs/application/states/version/version_state.dart';
import '../../../../core/bloc/states/base_init_state.dart';
import '../../../../core/bloc/states/base_states.dart';

class ApplicationState {
  VersionState versionState;
  GeneralState splashState;
  GeneralState userProfile;
  bool isHomeDrawerOpened;
  bool isSideDrawerShowed;
  Function? setHandleOfDrawer;
  bool isBottomBarShowed;

  ApplicationState({
    required this.versionState,
    required this.splashState,
    this.setHandleOfDrawer,
    required this.isSideDrawerShowed,
    required this.isHomeDrawerOpened,
    required this.isBottomBarShowed,
    required this.userProfile,
  });

  factory ApplicationState.initialState() => ApplicationState(
        versionState: VersionState.loadingAll(),
        splashState: BaseInitState(),
        userProfile: BaseInitState(),
        isHomeDrawerOpened: false,
        isBottomBarShowed: true,
        isSideDrawerShowed: false,
      );

  ApplicationState copyWith(
      {VersionState? versionState,
      GeneralState? splashState,
      GeneralState? userProfile,
      Function? setHandleOfDrawer,
      bool? isHomeDrawerOpened,
      bool? isSideDrawerShowed,
      bool? isBottomBarShowed}) {
    return ApplicationState(
      versionState: versionState ?? this.versionState,
      splashState: splashState ?? this.splashState,
      setHandleOfDrawer: setHandleOfDrawer ?? this.setHandleOfDrawer,
      isSideDrawerShowed: isSideDrawerShowed ?? this.isSideDrawerShowed,
      isHomeDrawerOpened: isHomeDrawerOpened ?? this.isHomeDrawerOpened,
      isBottomBarShowed: isBottomBarShowed ?? this.isBottomBarShowed,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
