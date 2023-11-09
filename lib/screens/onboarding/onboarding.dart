import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<OnboardingBloc, OnboardingInitial>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF001F3F), // Couleur en format hexadécimal
                    Color(0xFF0962BD), // Couleur en format hexadécimal
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: KeyedSubtree(
                      key: ValueKey(state.currentPage),
                      child: PageView(
                        controller: PageController(
                          initialPage: state.currentPage,
                          keepPage: true,
                        ),
                        onPageChanged: (int page) {
                          context
                              .read<OnboardingBloc>()
                              .add(OnboardingEventChange(page));
                        },
                        children: state.pages,
                      ),
                    ),
                  ),
                  _buildIndicators(state.currentPage),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildIndicators(int currentPage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildIndicator(currentPage == 0),
      const SizedBox(width: 8),
      _buildIndicator(currentPage == 1),
      const SizedBox(width: 8),
      _buildIndicator(currentPage == 2),
    ],
  );
}

Widget _buildIndicator(bool isActive) {
  return Container(
    width: isActive ? 16 : 8,
    height: 8,
    decoration: BoxDecoration(
      color: isActive ? Colors.white : Colors.grey,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
