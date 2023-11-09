import 'package:NearCard/blocs/auth/auth_bloc.dart';
import 'package:NearCard/screens/auth/login.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(body: BlocBuilder<AuthBloc, AuthInitial>(
        builder: (context, state) {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 56,
                  ),
                  DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: TitleSection()),
                  SizedBox(
                    height: 24,
                  ),
                  DelayedDisplay(
                      delay: Duration(milliseconds: 700), child: FormSection()),
                  SizedBox(
                    height: 16,
                  ),
                  DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: ButtonSection()),
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
          'Créer un compte',
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
          'créer un compte et commencer à partager vos cartes de visite !',
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
        return SizedBox(
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
                controller: state.signupEmailController,
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
                onChanged: (value) {
                  context.read<AuthBloc>().add(AuthEventSetIsPasswordSame());
                  context.read<AuthBloc>().add(AuthEventSetPasswordValidity());
                },
                obscureText: !state.ispasswordVisible,
                controller: state.signupPasswordController,
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
            const SizedBox(
              height: 8,
            ),
            if (state.passwordValidity != "")
              Text(
                state.passwordValidity,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Confirmer le mot de passe',
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
                onChanged: (value) {
                  context.read<AuthBloc>().add(AuthEventSetIsPasswordSame());
                },
                obscureText: !state.ispasswordVisible,
                controller: state.signupConfirmPasswordController,
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
                  hintText: 'Confirmer le mot de passe',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (!state.isPasswordSame)
              const Text(
                "Les mots de passe ne correspondent pas",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: const Color(0xFF001F3F),
                  checkColor: Colors.white,
                  value: state.termsAccepted,
                  onChanged: (value) {
                    context
                        .read<AuthBloc>()
                        .add(AuthEventSetTermsAccepted(value ?? false));
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthEventSetTermsAccepted(!state.termsAccepted));
                    },
                    child: Text(
                      'J\'accepte les Conditions Générales d\'Utilisation et la Politique de Confidentialité de NearCard',
                      style: TextStyle(
                          decoration: state.termsAccepted
                              ? TextDecoration.lineThrough
                              : null,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
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
    return BlocBuilder<AuthBloc, AuthInitial>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: 260,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventSignup(context));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff001f3f)),
                  ),
                  child: const Text(
                    'S\'inscrire',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Déja inscrit ?",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Connectez-vous",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Color(0xFF001F3F),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
          ],
        );
      },
    );
  }
}
