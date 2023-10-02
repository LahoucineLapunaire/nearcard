import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

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
                delay: Duration(milliseconds: 500),
                child: SizedBox(
                    width: 250,
                    height: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.location_on,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingEventChange(state.currentPage - 1));
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingEventChange(state.currentPage + 1));
                      },
                      icon: Icon(Icons.arrow_forward, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              DelayedDisplay(
                delay: Duration(milliseconds: 800),
                child: const Text(
                  'Géolocalisation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DelayedDisplay(
                delay: Duration(milliseconds: 800),
                child: const Text(
                  'Grâce à la géolocalisation, vous pouvez envoyer et recevoir les cartes de visite autour de vous quand vous le souhaitez !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
