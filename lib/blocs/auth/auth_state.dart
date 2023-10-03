part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  //Signup state
  final TextEditingController signupEmailController;
  final TextEditingController signupPasswordController;
  final TextEditingController signupConfirmPasswordController;
  final bool termsAccepted;
  final String signupError;

  final bool isPasswordSame;
  final String passwordValidity;
  final bool ispasswordVisible;

  //Login state
  final TextEditingController loginEmailController;
  final TextEditingController loginPasswordController;
  final String loginError;

  AuthInitial(
      this.signupEmailController,
      this.signupPasswordController,
      this.signupConfirmPasswordController,
      this.termsAccepted,
      this.signupError,
      this.isPasswordSame,
      this.passwordValidity,
      this.ispasswordVisible,
      this.loginEmailController,
      this.loginPasswordController,
      this.loginError);

  AuthInitial copyWith({
    TextEditingController? signupEmailController,
    TextEditingController? signupPasswordController,
    TextEditingController? signupConfirmPasswordController,
    bool? termsAccepted,
    String? signupError,
    bool? isPasswordSame,
    String? passwordValidity,
    bool? ispasswordVisible,
    TextEditingController? loginEmailController,
    TextEditingController? loginPasswordController,
    String? loginError,
  }) {
    return AuthInitial(
      signupEmailController ?? this.signupEmailController,
      signupPasswordController ?? this.signupPasswordController,
      signupConfirmPasswordController ?? this.signupConfirmPasswordController,
      termsAccepted ?? this.termsAccepted,
      signupError ?? this.signupError,
      isPasswordSame ?? this.isPasswordSame,
      passwordValidity ?? this.passwordValidity,
      ispasswordVisible ?? this.ispasswordVisible,
      loginEmailController ?? this.loginEmailController,
      loginPasswordController ?? this.loginPasswordController,
      loginError ?? this.loginError,
    );
  }
}
