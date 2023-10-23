part of '../application_bloc.dart';

extension VersioningExtension on ApplicationCubit {
  Future<void> checkVersion() async {
    print('checkVersion .. ');

    /// emit loading all state
    emit(state.copyWith(versionState: VersionState.loadingAll()));

     PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    /// get current version
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    /// emit current version success state
    emit(state.copyWith(
        versionState: state.versionState.copyWith(
      currentVersion: version,
    )));

    /// get the server version info and check validity
//    _getServerVersion(version);
  }

  bool _isValidVersion(
      {required String minimumSupported, required String current}) {

    /// /// TODO un comment
    // Version minVersion = Version.parse(minimumSupported);
    // Version currentVersion = Version.parse(current);
    // return currentVersion >= minVersion;
    return true;
  }

  bool _isUpdatableVersion({
    required String current,
    required String latest,
  }) {
    return true;
    /// TODO un comment
    // Version latestVersion = Version.parse(latest);
    // Version currentVersion = Version.parse(current);
    // return latestVersion > currentVersion;
  }

  // Future<void> _getServerVersion(String currentVersion) async {
  //   /// get server version
  //   final versionResult = await DIManager.findDep<MockAppGeneralRepository>()
  //       .getCurrentVersion(Platform.isAndroid
  //           ? MobilePlatformsEnum.Android
  //           : MobilePlatformsEnum.IOS);
  //
  //   /// request success
  //   if (versionResult.hasDataOnly) {
  //     final isValidVersion = _isValidVersion(
  //         minimumSupported: versionResult.data!.minimumSupportedVersion!,
  //         current: currentVersion);
  //     final isUpdatableVersion = _isUpdatableVersion(
  //         latest: versionResult.data!.latestVersion!, current: currentVersion);
  //
  //     emit(state.copyWith(
  //         versionState: state.versionState.copyWith(
  //             serverVersion: ServerVersionSuccessState(
  //                 isUpdatable: isUpdatableVersion,
  //                 isSupported: isValidVersion,
  //                 latestVersion: versionResult.data!.latestVersion,
  //                 updateUrl: versionResult.data!.updateUrl))));
  //
  //     if (isValidVersion) {
  //       if (isUpdatableVersion) {
  //         /// TODO:[sara] show optional update dialog
  //       }
  //     } else {
  //       /// TODO: [sara] show a mandatory update
  //     }
  //   } else {
  //     emit(state.copyWith(
  //         versionState: state.versionState.copyWith(
  //             serverVersion: BaseFailState(versionResult.error, callback: () {
  //       _getServerVersion(currentVersion);
  //     }))));
  //
  //     Future.delayed(Duration(seconds: 10), () {
  //       _getServerVersion(currentVersion);
  //     });
  //   }
  // }
}
