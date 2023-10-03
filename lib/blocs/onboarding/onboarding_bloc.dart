import 'package:NearCard/screens/login.dart';
import 'package:NearCard/screens/signup.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:NearCard/screens/onboarding1.dart';
import 'package:NearCard/screens/onboarding2.dart';
import 'package:NearCard/screens/onboarding3.dart';

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
            builder: (context) => SignupScreen(),
          ),
        );
      }
      if (event is OnboardingEventToLogin) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }
}
