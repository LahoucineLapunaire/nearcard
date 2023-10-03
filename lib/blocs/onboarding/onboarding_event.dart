part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

class OnboardingEventChange extends OnboardingEvent {
  final int page;

  OnboardingEventChange(this.page);
}

class OnboardingEventToSignup extends OnboardingEvent {
  final BuildContext context;

  OnboardingEventToSignup(this.context);
}

class OnboardingEventToLogin extends OnboardingEvent {
  final BuildContext context;

  OnboardingEventToLogin(this.context);
}
