import 'package:NearCard/main.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthInitial> {
  AuthBloc()
      : super(AuthInitial(
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          false,
          true,
          "",
          false,
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        )) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthEventSetTermsAccepted) {
        emit(state.copyWith(termsAccepted: event.termsAccepted));
      }
      if (event is AuthEventSetIsPasswordSame) {
        if (state.signupPasswordController.text ==
            state.signupConfirmPasswordController.text) {
          emit(state.copyWith(isPasswordSame: true));
        } else {
          emit(state.copyWith(isPasswordSame: false));
        }
      }
      if (event is AuthEventSetPasswordValidity) {
        bool lenght = state.signupPasswordController.text.length >= 8;
        bool upperCase =
            state.signupPasswordController.text.contains(RegExp(r'[A-Z]'));
        bool specialChar = state.signupPasswordController.text
            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
        bool number =
            state.signupPasswordController.text.contains(RegExp(r'[0-9]'));
        String message = "";

        if (!lenght || !upperCase || !specialChar || !number) {
          message = "Veuillez saisir un mot de passe contenant :";
        }
        if (!lenght) {
          message += "\n-Au moins 8 caractères,";
        }
        if (!upperCase) {
          message += "\n-Au moins une lettre majuscule,";
        }
        if (!specialChar) {
          message += "\n-Au moins un caractère spécial, ";
        }
        if (!number) {
          message += "\n-Au moins un chiffre,";
        }
        emit(state.copyWith(passwordValidity: message));
      }

      if (event is AuthEventSetPasswordVisibility) {
        emit(state.copyWith(ispasswordVisible: event.ispasswordVisible));
      }

      //____________________ SignUp _________________________
      if (event is AuthEventSignup) {
        try {
          if (state.signupEmailController.text.isEmpty ||
              state.signupPasswordController.text.isEmpty ||
              state.signupConfirmPasswordController.text.isEmpty) {
            displayError(event.context, "Veuillez remplir tous les champs");
            return;
          }
          if (!state.termsAccepted) {
            displayError(event.context,
                "Veuillez accepter les conditions générales d'utilisation");
            return;
          }
          if (!state.isPasswordSame) {
            displayError(
                event.context, "Les mots de passe ne sont pas identiques");
            return;
          }
          if (state.passwordValidity.isNotEmpty) {
            displayError(
                event.context, "Veuillez saisir un mot de passe valide");
            return;
          }

          FirebaseAuth auth = FirebaseAuth.instance;
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: state.signupEmailController.text,
            password: state.signupPasswordController.text,
          );

          displayMessage(
              event.context, "Inscription réussie, veuillez patienter");
        } catch (e) {
          print("Erreur inattendue : $e");
          displayError(event.context, e.toString().split('] ')[1]);
        }
      }

      if (event is AuthEventLogin) {
        try {
          if (state.loginEmailController.text.isEmpty ||
              state.loginPasswordController.text.isEmpty) {
            displayError(event.context, "Veuillez remplir tous les champs");
            return;
          }
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.signInWithEmailAndPassword(
            email: state.loginEmailController.text,
            password: state.loginPasswordController.text,
          );
          // La connexion a réussi, continuez ici
          displayMessage(event.context, "Connexion réussie");
        } catch (e) {
          if (e.toString().contains("INVALID_LOGIN_CREDENTIALS")) {
            displayError(event.context, "Email ou mot de passe incorrect");
          }
          if (e.toString().contains("badly formatted")) {
            displayError(event.context, "Veuillez saisir un email valide");
          } else {
            // Gérez toutes les autres exceptions ici
            print("Erreur inattendue : $e");
            displayError(event.context, e.toString().split('] ')[1]);
          }
        }
      }
      if (event is AuthEventResetPassword) {
        try {
          final FirebaseAuth auth = FirebaseAuth.instance;
          await auth.sendPasswordResetEmail(
              email: state.resetPasswordController.text);
          displayMessage(event.context,
              "Un email de réinitialisation de mot de passe vous a été envoyé");
        } catch (e) {
          displayError(event.context, e.toString().split('] ')[1]);
        }
      }
    });
  }
}
