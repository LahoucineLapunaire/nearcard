import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthInitial> {
  AuthBloc()
      : super(AuthInitial(
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            false,
            "",
            true,
            "",
            false,
            TextEditingController(),
            TextEditingController(),
            "")) {
    on<AuthEvent>((event, emit) {
      if (event is AuthEventSetTermsAccepted) {
        emit(state.copyWith(termsAccepted: event.termsAccepted));
      }
      if (event is AuthEventSetSignupError) {
        emit(state.copyWith(signupError: event.signupError));
      }
      if (event is AuthEventSetIsPasswordSame) {
        emit(state.copyWith(isPasswordSame: event.isPasswordSame));
      }
      if (event is AuthEventSetPasswordValidity) {
        if (state.signupPasswordController.text ==
            state.signupConfirmPasswordController.text) {
          emit(state.copyWith(
              isPasswordSame: true, passwordValidity: "Mot de passe valide"));
        } else {
          emit(state.copyWith(
              isPasswordSame: false,
              passwordValidity: "Mot de passe invalide"));
        }
      }
      if (event is AuthEventSetPasswordVisibility) {
        emit(state.copyWith(ispasswordVisible: event.ispasswordVisible));
      }
      if (event is AuthEventSetLoginError) {
        emit(state.copyWith(loginError: event.loginError));
      }
    });
  }
}
