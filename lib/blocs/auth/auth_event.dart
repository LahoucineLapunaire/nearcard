part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthEventSetTermsAccepted extends AuthEvent {
  final bool termsAccepted;

  AuthEventSetTermsAccepted(this.termsAccepted);
}

final class AuthEventSetSignupError extends AuthEvent {
  final String signupError;

  AuthEventSetSignupError(this.signupError);
}

final class AuthEventSetIsPasswordSame extends AuthEvent {
  final bool isPasswordSame;

  AuthEventSetIsPasswordSame(this.isPasswordSame);
}

final class AuthEventSetPasswordValidity extends AuthEvent {}

final class AuthEventSetLoginError extends AuthEvent {
  final String loginError;

  AuthEventSetLoginError(this.loginError);
}

final class AuthEventSetPasswordVisibility extends AuthEvent {
  final bool ispasswordVisible;

  AuthEventSetPasswordVisibility(this.ispasswordVisible);
}

final class AuthEventSignup extends AuthEvent {}

final class AuthEventLogin extends AuthEvent {}
