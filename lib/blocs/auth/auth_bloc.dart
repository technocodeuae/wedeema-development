import 'dart:io';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/core/bloc/states/base_init_state.dart';

import '../../../../blocs/auth/states/auth_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../core/models/empty_entity.dart';
import '../../repos/auth/auth_repo_i.dart';
import '../../ui/work_focus_version/auth/pages/sign_in_page.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthFacade authRepo;

  AuthCubit(
    this.authRepo,
  ) : super(AuthState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();

    /// get login mode and employee mode
    // emit(state.copyWith(
    //     loginMode: sharedPrefs.getLoginMode(),
    //     employeeMode: sharedPrefs.getEmployeeMode(),
    //     workplace: sharedPrefs.getWorkplaceEntity()));
  }

  // Future<void> tempWorkplaceSelection(WorkplaceEntity workplace) async {
  //   emit(this.state.copyWith(workplace: workplace));
  //   DIManager.findDep<AppColorsController>()
  //       .setPrimaryColor(workplace.color);
  // }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loginState: BaseLoadingState()));
    final result = await authRepo.authenticate(
      email: email,
      password: password,
    );
    if (result.hasDataOnly) {
      var fcmToken = DIManager.findDep<SharedPrefs>().getFCMToken();
      DIManager.findDep<SharedPrefs>()
        ..setToken(result.data?.access_token ?? '');
      DIManager.findDep<SharedPrefs>()..setUserID(result.data?.user?.id ?? -1);
      DIManager.findDep<SharedPrefs>()
        ..setNotificationsStatus(result.data?.user?.notification_status);
      DIManager.findDep<SharedPrefs>()
        ..setImageProfile(result.data?.user?.profile_pic ?? '');

      // if(fcmToken != null ) await authRepo.firebase(token: fcmToken);
      // await DIManager.findDep<ProfileCubit>().getUserProfile();
      // DIManager.findDep<SharedPrefs>().setLoginMode(LoginModeEnum.NORMAL_MODE);

      emit(state.copyWith(loginState: LoginSuccessState(result.data!)));

      // await GlobalNotification.instance.setupNotification();
    } else {
      // if(result.error is UnauthorizedError){
      //   CustomSnackbar.showSnackbar(translate("login_error"));
      // }
      // else CustomSnackbar.showErrorSnackbar(result.error!);
      emit(
        state.copyWith(
          loginState: BaseFailState(
            result.error,
            callback: () => this.login(
              password: password,
              email: email,
            ),
          ),
        ),
      );
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String userName,
    String? phoneNumber,
    required int city,
    // required String addressLatitude,
    // required String addressLongitude,
    String? aboutMe,
    File? image,
    required int gender,
  }) async {
    emit(state.copyWith(loginState: BaseLoadingState()));
    final result = await authRepo.register(
      userName: userName,
      image: image,
      email: email,
      password: password,
      gender: gender,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      city: city,
      // addressLatitude: addressLatitude,
      // addressLongitude: addressLongitude,
      aboutMe: aboutMe,
    );
    if (result.hasDataOnly) {
      var fcmToken = DIManager.findDep<SharedPrefs>().getFCMToken();

      // if(fcmToken != null ) await authRepo.firebase(token: fcmToken);
      // await DIManager.findDep<ProfileCubit>().getUserProfile();
      DIManager.findDep<SharedPrefs>()..setToken(result.data?.access_token!);
      DIManager.findDep<SharedPrefs>()..setUserID(result.data?.user!.id!);
      DIManager.findDep<SharedPrefs>()
        ..setNotificationsStatus(result.data?.user?.notification_status);
      DIManager.findDep<SharedPrefs>()
        ..setImageProfile(result.data?.user?.profile_pic ?? "");

      // DIManager.findDep<SharedPrefs>().setLoginMode(LoginModeEnum.NORMAL_MODE);
      // DIManager.findDep<SharedPrefs>().setEmployeeMode(EmployeeModesEnum.SOCIAL_MODE);

      emit(state.copyWith(registerState: RegisterSuccessState(result.data!)));
      // await GlobalNotification.instance.setupNotification();
    } else {
      // if (result.error is UnauthorizedError) {
      //   CustomSnackbar.showSnackbar(translate("login_error"));
      // } else
      //   CustomSnackbar.showErrorSnackbar(result.error!);
      emit(
        state.copyWith(
          registerState: BaseFailState(
            result.error,
            callback: () => this.register(
              userName: userName,
              image: image,
              email: email,
              password: password,
              gender: gender,
              firstName: firstName,
              lastName: lastName,
              phoneNumber: phoneNumber,
              city: city,
              // addressLongitude: addressLongitude,
              // addressLatitude: addressLatitude,
              aboutMe: aboutMe,
            ),
          ),
        ),
      );
    }
  }

// Future<void> loginToCheckPassword({
//   required String username,
//   required String password,
// }) async {
//   emit(state.copyWith(loginState: BaseLoadingState()));
//   final result = await authRepo.authenticate(
//     userName: username,
//     password: password,
//     orgId: state.workplace!.id!,
//   );
//   if (result.hasDataOnly) {
//     emit(state.copyWith(loginState: BaseSuccessState()));
//   } else {
//     CustomSnackbar.showErrorSnackbar(result.error!);
//   }
// }
//
//

  Future<void> logout() async {
    emit(state.copyWith(logout: BaseLoadingState()));

    final result = await authRepo.logout();

    if (result.hasDataOnly) {
      DIManager.findDep<SharedPrefs>().logout();

      emit(state.copyWith(logout: LogOutSuccessState(result.data!)));
      DIManager.findNavigator().offAll(
        SignInPage.routeName,
      );
    } else {
      emit(
        state.copyWith(
          logout: BaseFailState(
            result.error,
            callback: () => this.logout(),
          ),
        ),
      );
    }
  }

  Future<void> changePassword(
    String password, {
    String? email,
    String? mobile,
    VoidCallback? onDone,
    VoidCallback? onError,
  }) async {
    emit(state.copyWith(changePassword: BaseLoadingState()));

    final result = await authRepo.changePassword(email, mobile, password);

    if (result.hasDataOnly) {
      if (onDone != null) {
        onDone();
      }
      emit(state.copyWith(
          changePassword: ChangePasswordSuccessState(result.data!)));
    } else {
      CustomSnackbar.showErrorSnackbar(result.error!);
      if (onError != null) {
        onError();
      }
      emit(
        state.copyWith(
          changePassword: BaseFailState(result.error,
              callback: () => this.changePassword(password, email: email)),
        ),
      );
    }
    return null;
  }

  Future<void> forgetPassword(String email) async {
    emit(state.copyWith(forgetPassword: BaseLoadingState()));

    final result = await authRepo.forgetPassword(email);

    if (result.hasDataOnly) {
      emit(state.copyWith(
          forgetPassword: ForgetPasswordSuccessState(result.data!)));
    } else {
      CustomSnackbar.showErrorSnackbar(result.error!);

      emit(
        state.copyWith(
          forgetPassword: BaseFailState(result.error,
              callback: () => this.forgetPassword(email)),
        ),
      );
    }
    return null;
  }

  Future<void> validateMobileNumber(String otpCode, String mobile,
      {bool isChangePassword = false,
      VoidCallback? onDone,
      VoidCallback? onError}) async {
    emit(state.copyWith(verification: BaseLoadingState()));

    final result =
        await authRepo.validateMobileNumber(otpCode, mobile, isChangePassword);

    if (result.hasDataOnly) {
      if (onDone != null) {
        onDone();
      }
      emit(state.copyWith(
          verification: VerificationCodeSuccessState(EmptyEntity(''))));
    } else {
      CustomSnackbar.showErrorSnackbar(result.error!);
      if (onError != null) {
        onError();
      }
      emit(
        state.copyWith(
          verification: BaseFailState(
            result.error,
          ),
        ),
      );
    }
    return null;
  }

  Future<void> sendVerificationCode(String countryCode, String mobile,
      {VoidCallback? onDone,
      VoidCallback? onError,
      bool isChangePassword = false}) async {
    emit(state.copyWith(verification: BaseLoadingState()));

    final result = await authRepo.sendVerificationCode(
        countryCode, mobile, isChangePassword);

    if (result.hasDataOnly) {
      if (onDone != null) {
        onDone();
      }
      emit(state.copyWith(
          changePassword: VerificationCodeSuccessState(EmptyEntity(''))));
    } else {
      CustomSnackbar.showErrorSnackbar(result.error!);
      if (onError != null) {
        onError();
      }
      emit(
        state.copyWith(
          verification: BaseFailState(
            result.error,
          ),
        ),
      );
    }
    return null;
  }

  refresh() {
    emit(state.copyWith(loginState: BaseLoadingState()));
    emit(state.copyWith(loginState: BaseInitState()));
  }

//
// Future<void> logoutLocally() async {
//   emit(state.copyWith(logout: BaseLoadingState()));
//
//   // authRepo.logout();
//   DIManager.findDep<SharedPrefs>().logout();
//   _resetWorkplace();
//   emit(state.copyWith(logout: BaseSuccessState()));
//   DIManager.findNavigator().offAll(
//     SelectWorkplacePage.routeName,
//   );
// }
//
//
// Future<void> refreshToken() async {
//   emit(state.copyWith(refreshToken: BaseLoadingState()));
//   print('refreshToken ${state.refreshToken}');
//
//   final result = await authRepo.refreshToken();
//
//   if (result.hasDataOnly) {
//     emit(state.copyWith(refreshToken: BaseSuccessState()));
//   } else {
//     CustomSnackbar.showErrorSnackbar(result.error!);
//
//     emit(
//       state.copyWith(
//         refreshToken: BaseFailState(
//           result.error,
//           callback: logout,
//         ),
//       ),
//     );
//   }
//   return null;
// }
//
//
// void _resetWorkplace() {
//   print('reset...');
//   DIManager.findDep<AppColorsController>()
//       .resetPrimaryColor();
//   emit(state.copyWith(workplace: null));
// }
}
