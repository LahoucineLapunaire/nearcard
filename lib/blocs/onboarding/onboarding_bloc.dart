import 'package:NearCard/screens/auth/login.dart';
import 'package:NearCard/screens/auth/signup.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:NearCard/screens/onboarding/onboarding1.dart';
import 'package:NearCard/screens/onboarding/onboarding2.dart';
import 'package:NearCard/screens/onboarding/onboarding3.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingInitial> {
  OnboardingBloc() : super(OnboardingInitial(0)) {
    on<OnboardingEvent>((event, emit) {
      if (event is OnboardingEventChange) {
        emit(OnboardingInitial(event.page));
      }
      if (event is OnboardingEventToSignup) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          ),
        );
      }
      if (event is OnboardingEventToLogin) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }
}
