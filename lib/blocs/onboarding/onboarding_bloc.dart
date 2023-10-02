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
      // TODO: implement event handler
      if (event is OnboardingEventChange) {
        emit(OnboardingInitial(event.page));
      }
    });
  }
}
