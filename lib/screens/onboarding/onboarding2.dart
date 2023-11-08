import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              SizedBox(
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
                            FontAwesomeIcons.qrcode,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )),
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
              const Text(
                'Qr Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Grâce à votre Qr Code, vous pouvez partager vos informations de contact avec vos proches et vos clients.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
