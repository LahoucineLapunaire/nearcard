part of 'onboarding_bloc.dart';

sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {
  List<Widget> pages = [
    const Onboarding1(),
    const Onboarding2(),
    const Onboarding3()
  ];
  int currentPage = 0;

  OnboardingInitial(this.currentPage);
}
