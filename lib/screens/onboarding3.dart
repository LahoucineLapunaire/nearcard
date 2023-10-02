import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:NearCard/screens/login.dart';
import 'package:NearCard/screens/signup.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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
                  child: Center(
                    child: Icon(
                      Icons.share,
                      size: 200,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingEventChange(state.currentPage - 1));
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              DelayedDisplay(
                delay: Duration(milliseconds: 800),
                child: const Text(
                  'Partagez votre carte de visite en un clic',
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
                  'Partagez votre carte de visite en un clic avec vos clients et vos partenaires via un lien',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DelayedDisplay(
                delay: Duration(milliseconds: 1100),
                child: Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff001f3f)),
                      ),
                      child: Text(
                        'S\'inscrire',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 8),
              DelayedDisplay(
                delay: Duration(milliseconds: 1100),
                child: Container(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                      ),
                      child: Text(
                        "Dèjà inscrit ? se connecter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
