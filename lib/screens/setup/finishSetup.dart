import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:NearCard/screens/auth/login.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class FinishSetup extends StatelessWidget {
  const FinishSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 56,
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: 500), child: TitleSection()),
                SizedBox(
                  height: 40,
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: 500), child: ButtonSection()),
              ],
            ),
          ),
        );
      },
    ));
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            child: const Icon(Icons.check, size: 60, color: Colors.black)),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Votre compte est prêt !',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Veuillez vérifier votre adresse email pour pouvoir utiliser NearCard.Pour recevoir l\'email, veuillez appuyer sur le bouton ci-dessous et vous reconnecter à votre compte.',
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

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    try {
                      if (state.nameController.text == "" ||
                          state.prenameController.text == "" ||
                          state.titleController.text == "" ||
                          state.companyController.text == "" ||
                          state.picture == "" ||
                          state.bgColor == "" ||
                          state.textColor == "") {
                        displayError(
                            context, "Veuillez vériifer vos informations");
                      }
                      context.read<SetupBloc>().add(SetupEventFirstSetup(
                          context,
                          state.nameController.text,
                          state.prenameController.text,
                          state.titleController.text,
                          state.companyController.text,
                          state.numberController.text,
                          state.addressController.text,
                          state.linkedinController.text,
                          state.websiteController.text,
                          state.picture,
                          state.bgColor,
                          state.textColor));
                      displayMessage(context,
                          "Email envoyé ! Veuillez vérifier votre boîte mail");
                    } catch (e) {
                      displayError(context, e.toString());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff001f3f)),
                  ),
                  child: const Text(
                    'Envoyer l\'email',
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
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                    Navigator.push(
                        // New line
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
                    "J'ai vérifié mon Email",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }
}
