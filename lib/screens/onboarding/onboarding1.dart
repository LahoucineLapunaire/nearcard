import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingInitial>(
      builder: (context, state) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedDisplay(
                delay: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingEventChange(state.currentPage + 1));
                      },
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              const DelayedDisplay(
                delay: Duration(milliseconds: 800),
                child: Text(
                  'NearCard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const DelayedDisplay(
                delay: Duration(milliseconds: 800),
                child: Text(
                  'Partagez votre carte de visite en un clic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
