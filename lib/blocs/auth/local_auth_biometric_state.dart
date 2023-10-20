part of 'local_auth_biometric_cubit.dart';

@immutable
abstract class LocalAuthBiometricState {}

class LocalAuthBiometricInitState extends LocalAuthBiometricState {
  @override
  String toString() {
    return 'LocalAuthBiometricInitState{}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is LocalAuthBiometricInitState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class LocalAuthWithoutBiometricState extends LocalAuthBiometricState {
  @override
  bool operator ==(Object other) => identical(this, other) || other is LocalAuthWithoutBiometricState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'LocalAuthWithoutBiometricState{}';
  }
}

class LocalAuthWithBiometricState extends LocalAuthBiometricState {
  final String userName;
  final String password;
  final String orgId;

  LocalAuthWithBiometricState(this.userName, this.password, this.orgId);

  @override
  String toString() {
    return 'LocalAuthWithBiometricState{userName: $userName, password: $password, orgId: $orgId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalAuthWithBiometricState &&
          runtimeType == other.runtimeType &&
          userName == other.userName &&
          password == other.password &&
          orgId == other.orgId;

  @override
  int get hashCode => userName.hashCode ^ password.hashCode ^ orgId.hashCode;
}

class LocalAuthWithBiometricOrPinState extends LocalAuthBiometricState {
  LocalAuthWithBiometricOrPinState();

  @override
  String toString() {
    return 'LocalAuthWithBiometricOrPinState{}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is LocalAuthWithBiometricOrPinState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
