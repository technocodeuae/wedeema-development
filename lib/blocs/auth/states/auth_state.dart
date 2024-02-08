
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/auth/entity/auth_entity.dart';

class AuthState {

  GeneralState loginState;
  GeneralState registerState;
  GeneralState logout;
  GeneralState deletAccount;
  GeneralState refreshToken;
  GeneralState changePassword;
  GeneralState forgetPassword;
  GeneralState verification;

  AuthState({
    required this.registerState,
    required this.loginState,
    required this.logout,
    required this.deletAccount,
    required this.refreshToken,
    required this.changePassword,
    required this.forgetPassword,
    required this.verification,
  });

  factory AuthState.initialState() => AuthState(

    loginState: BaseInitState(),
    registerState: BaseInitState(),
    logout: BaseInitState(),
    deletAccount: BaseInitState(),
    refreshToken: BaseInitState(),
    changePassword: BaseInitState(),
    forgetPassword: BaseInitState(),
    verification: BaseInitState(),
  );

  AuthState copyWith({

    GeneralState? loginState,
    GeneralState? registerState,
    GeneralState? logout,
    GeneralState? deletAccount,
    GeneralState? refreshToken,
    GeneralState? changePassword,
    GeneralState? verification,
    GeneralState? forgetPassword,
  }) {
    return AuthState(

      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      logout: logout ?? this.logout,
      deletAccount: deletAccount ?? this.deletAccount,
      verification: verification ?? this.verification,
      refreshToken: refreshToken ?? this.refreshToken,
      forgetPassword: forgetPassword ?? this.forgetPassword,
      changePassword: changePassword ?? this.changePassword,
    );
  }
}



class LoginSuccessState extends BaseSuccessState {
  final AuthenticateEntity auth;

  LoginSuccessState(this.auth);
}

class RegisterSuccessState extends BaseSuccessState {
  final AuthenticateEntity auth;

  RegisterSuccessState(this.auth);
}



class LogOutSuccessState extends BaseSuccessState {
  final EmptyEntity data;

  LogOutSuccessState(this.data);
}
class DeleteAccountSuccessState extends BaseSuccessState {
  final EmptyEntity data;

  DeleteAccountSuccessState(this.data);
}
class ChangePasswordSuccessState extends BaseSuccessState {
  final EmptyEntity data;

  ChangePasswordSuccessState(this.data);
}
class VerificationCodeSuccessState extends BaseSuccessState {
  final EmptyEntity data;

  VerificationCodeSuccessState(this.data);
}

class ForgetPasswordSuccessState extends BaseSuccessState {
  final EmptyEntity data;

  ForgetPasswordSuccessState(this.data);
}
