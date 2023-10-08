import 'package:NearCard/blocs/auth/auth_bloc.dart';
import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:NearCard/blocs/router/router_bloc.dart';
import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:NearCard/screens/app/router.dart';
import 'package:NearCard/screens/onboarding/onboarding.dart';
import 'package:NearCard/screens/setup/setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth.authStateChanges().listen((User? user) {
    if (user != null) {
      if (user.emailVerified) {
        print("Verified");
        runApp(const Verified());
      } else {
        print("Not verified");
        runApp(const NotVerified());
      }
    } else {
      print("Unlogged");
      runApp(const UnLogged());
    }
  });
}

class Verified extends StatelessWidget {
  const Verified({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NearCard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xff001f3f,
            <int, Color>{
              50: Color(0xffe5f1f4),
              100: Color(0xffbfe0e7),
              200: Color(0xff94cdd6),
              300: Color(0xff68bac5),
              400: Color(0xff47aeb9),
              500: Color(0xff27a2ad),
              600: Color(0xff219b9f),
              700: Color(0xff1b8c8f),
              800: Color(0xff177d7f),
              900: Color(0xff0f5f60),
            },
          ),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<RouterBloc>(
              create: (context) => RouterBloc(),
            ),
            BlocProvider(create: (context) => CurrentUserBloc()),
          ],
          child: const RouterScreen(),
        ));
  }
}

class NotVerified extends StatelessWidget {
  const NotVerified({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xff001f3f,
          <int, Color>{
            50: Color(0xffe5f1f4),
            100: Color(0xffbfe0e7),
            200: Color(0xff94cdd6),
            300: Color(0xff68bac5),
            400: Color(0xff47aeb9),
            500: Color(0xff27a2ad),
            600: Color(0xff219b9f),
            700: Color(0xff1b8c8f),
            800: Color(0xff177d7f),
            900: Color(0xff0f5f60),
          },
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SetupBloc>(
            create: (context) => SetupBloc(),
          ),
        ],
        child: const SetupScreen(),
      ),
    );
  }
}

class UnLogged extends StatelessWidget {
  const UnLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xff001f3f,
          <int, Color>{
            50: Color(0xffe5f1f4),
            100: Color(0xffbfe0e7),
            200: Color(0xff94cdd6),
            300: Color(0xff68bac5),
            400: Color(0xff47aeb9),
            500: Color(0xff27a2ad),
            600: Color(0xff219b9f),
            700: Color(0xff1b8c8f),
            800: Color(0xff177d7f),
            900: Color(0xff0f5f60),
          },
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
        ],
        child: const OnboardingScreen(),
      ),
    );
  }
}
