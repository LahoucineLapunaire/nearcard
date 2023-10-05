part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthEventSetTermsAccepted extends AuthEvent {
  final bool termsAccepted;

  AuthEventSetTermsAccepted(this.termsAccepted);
}

final class AuthEventSetIsPasswordSame extends AuthEvent {}

final class AuthEventSetPasswordValidity extends AuthEvent {}

final class AuthEventSetPasswordVisibility extends AuthEvent {
  final bool ispasswordVisible;

  AuthEventSetPasswordVisibility(this.ispasswordVisible);
}

final class AuthEventSignup extends AuthEvent {
  final BuildContext context;

  AuthEventSignup(this.context);
}

final class AuthEventLogin extends AuthEvent {
  final BuildContext context;

  AuthEventLogin(this.context);
}
