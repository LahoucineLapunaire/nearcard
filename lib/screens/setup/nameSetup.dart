import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:NearCard/widgets/breadcrumb.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class NameSetup extends StatelessWidget {
  const NameSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 56,
                ),
                StepperBreadcrumbs(currentStep: state.currentPage),
                const SizedBox(
                  height: 32,
                ),
                const DelayedDisplay(
                    delay: Duration(milliseconds: 500), child: TitleSection()),
                const SizedBox(
                  height: 24,
                ),
                const DelayedDisplay(
                    delay: Duration(milliseconds: 700), child: FormSection()),
                const SizedBox(
                  height: 16,
                ),
                const DelayedDisplay(
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
            child: const Icon(Icons.person, size: 60, color: Colors.black)),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Nom et Prénom',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Veuillez saisir votre nom et prénom',
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
    return BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return Container(
          width: 300,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Nom',
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
                  state.nameController.text = value.toUpperCase();
                },
                controller: state.nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nom',
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
              height: 8,
            ),
            const Text(
              'Prenom',
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
                  //set first letter to uppercase
                  if (value.isNotEmpty) {
                    value = value[0].toUpperCase() + value.substring(1);
                  }
                  state.prenameController.text = value;
                },
                controller: state.prenameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.perm_identity),
                  hintText: 'Prenom',
                  hintStyle: TextStyle(
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
    return BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  style: ButtonStyle(
                    shadowColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: const Text(
                    "Retour",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
            const SizedBox(
              width: 50,
            ),
            Container(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  (state.nameController.text.isNotEmpty &&
                          state.prenameController.text.isNotEmpty)
                      ? context
                          .read<SetupBloc>()
                          .add(SetupEventChange(state.currentPage + 1))
                      : displayError(
                          context, "Veuillez remplir tous les champs");
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff001f3f)),
                ),
                child: const Text(
                  'Suivant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        );
      },
    );
  }
}
