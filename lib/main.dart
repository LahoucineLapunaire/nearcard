import 'package:NearCard/blocs/auth/auth_bloc.dart';
import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:NearCard/screens/onboarding.dart';
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
        runApp(Verified());
      } else {
        runApp(NotVerified());
      }
    } else {
      runApp(UnLogged());
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
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Verified"),
              ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  child: Text("Sign out")),
            ],
          ),
        ),
      ),
    );
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
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Not Verified"),
              ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  child: Text("Sign out")),
            ],
          ),
        ),
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
        primarySwatch: Colors.blueGrey,
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
