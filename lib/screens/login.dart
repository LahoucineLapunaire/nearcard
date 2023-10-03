import 'package:NearCard/blocs/auth/auth_bloc.dart';
import 'package:NearCard/screens/signup.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(body: BlocBuilder<AuthBloc, AuthInitial>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: const Column(
                children: [
                  const SizedBox(
                    height: 56,
                  ),
                  const TitleSection(),
                  const SizedBox(
                    height: 24,
                  ),
                  FormSection(),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonSection(),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bon retour !',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Bonjour ! Connectez-vous pour continuer',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthInitial>(
      builder: (context, state) {
        return Container(
          width: 300,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFe3e3e3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: state.loginEmailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Mot de passe',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFe3e3e3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                obscureText: !state.ispasswordVisible,
                controller: state.loginPasswordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                          AuthEventSetPasswordVisibility(
                              !state.ispasswordVisible));
                    },
                    icon: Icon(state.ispasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  hintText: 'Mot de passe',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 260,
          height: 40,
          child: ElevatedButton(
              onPressed: () {
                print("Se connecter");
                displayError(context, "error test");
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff001f3f)),
              ),
              child: const Text(
                'Se connecter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()));
              },
              style: ButtonStyle(
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pas de compte ?",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Inscrivez-vous",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              style: ButtonStyle(
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: const Text(
                "Mot de passe oublié ?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      ],
    );
  }
}
